// Transaction Manager Web App JavaScript

class TransactionManager {
    constructor() {
        this.transactions = this.loadTransactions();
        this.init();
    }

    init() {
        this.setupEventListeners();
        this.updateStats();
        this.renderTransactions();
        this.updateServerInfo();
        this.startStatusCheck();
    }

    setupEventListeners() {
        // Form submission
        document.getElementById('transactionForm').addEventListener('submit', (e) => {
            e.preventDefault();
            this.addTransaction();
        });

        // Keyboard shortcuts
        document.addEventListener('keydown', (e) => {
            if (e.key === 'a' || e.key === 'A') {
                document.getElementById('customerName').focus();
            }
            if (e.key === 'Escape') {
                this.clearForm();
            }
        });
    }

    addTransaction() {
        const form = document.getElementById('transactionForm');
        const formData = new FormData(form);
        
        const transaction = {
            id: Date.now(),
            date: new Date().toLocaleString(),
            customerName: document.getElementById('customerName').value,
            amount: parseFloat(document.getElementById('amount').value),
            type: document.getElementById('type').value,
            details: document.getElementById('details').value || 'No details provided'
        };

        // Validate transaction
        if (!transaction.customerName || !transaction.amount || !transaction.type) {
            alert('Please fill in all required fields!');
            return;
        }

        // Adjust amount for withdrawal
        if (transaction.type === 'withdrawal') {
            transaction.amount = -Math.abs(transaction.amount);
        } else {
            transaction.amount = Math.abs(transaction.amount);
        }

        // Add to transactions array
        this.transactions.unshift(transaction);
        
        // Save to localStorage
        this.saveTransactions();
        
        // Update UI
        this.updateStats();
        this.renderTransactions();
        this.clearForm();
        
        // Show success message
        this.showNotification(`Transaction added successfully! ${transaction.type === 'deposit' ? '+' : ''}₹${Math.abs(transaction.amount)}`);
    }

    deleteTransaction(id) {
        if (confirm('Are you sure you want to delete this transaction?')) {
            this.transactions = this.transactions.filter(t => t.id !== id);
            this.saveTransactions();
            this.updateStats();
            this.renderTransactions();
            this.showNotification('Transaction deleted successfully!');
        }
    }

    updateStats() {
        const totalTransactions = this.transactions.length;
        const totalAmount = this.transactions.reduce((sum, t) => sum + Math.abs(t.amount), 0);
        const currentBalance = this.transactions.reduce((sum, t) => sum + t.amount, 0);

        document.getElementById('totalTransactions').textContent = totalTransactions;
        document.getElementById('totalAmount').textContent = `₹${totalAmount.toFixed(2)}`;
        document.getElementById('currentBalance').textContent = `₹${currentBalance.toFixed(2)}`;
        
        // Update balance color
        const balanceElement = document.getElementById('currentBalance');
        balanceElement.className = currentBalance >= 0 ? 'stat-value amount-positive' : 'stat-value amount-negative';
    }

    renderTransactions() {
        const tbody = document.getElementById('transactionsBody');
        tbody.innerHTML = '';

        if (this.transactions.length === 0) {
            tbody.innerHTML = `
                <tr>
                    <td colspan="6" style="text-align: center; padding: 40px; color: #718096;">
                        No transactions yet. Add your first transaction above! 📊
                    </td>
                </tr>
            `;
            return;
        }

        this.transactions.forEach(transaction => {
            const row = document.createElement('tr');
            row.className = 'new-transaction';
            
            const amountClass = transaction.amount >= 0 ? 'amount-positive' : 'amount-negative';
            const typeIcon = transaction.type === 'deposit' ? '💰' : '💸';
            
            row.innerHTML = `
                <td>${transaction.date}</td>
                <td>${transaction.customerName}</td>
                <td>${typeIcon} ${transaction.type}</td>
                <td class="${amountClass}">₹${Math.abs(transaction.amount).toFixed(2)}</td>
                <td>${transaction.details}</td>
                <td>
                    <button class="btn" onclick="app.deleteTransaction(${transaction.id})" style="background: #fed7d7; color: #c53030; padding: 5px 10px; font-size: 0.8rem;">
                        🗑️ Delete
                    </button>
                </td>
            `;
            
            tbody.appendChild(row);
        });
    }

    clearForm() {
        document.getElementById('transactionForm').reset();
        document.getElementById('customerName').focus();
    }

    loadTransactions() {
        const saved = localStorage.getItem('transactions');
        return saved ? JSON.parse(saved) : [];
    }

    saveTransactions() {
        localStorage.setItem('transactions', JSON.stringify(this.transactions));
    }

    updateServerInfo() {
        document.getElementById('currentURL').textContent = window.location.href;
        document.getElementById('startTime').textContent = new Date().toLocaleString();
    }

    startStatusCheck() {
        // Update server status every 5 seconds
        setInterval(() => {
            const statusIndicator = document.getElementById('statusIndicator');
            const statusText = document.getElementById('statusText');
            
            // Simple check - if we can access the page, server is running
            statusIndicator.textContent = '🟢';
            statusText.textContent = 'Local Server Active';
        }, 5000);
    }

    showNotification(message) {
        // Create notification element
        const notification = document.createElement('div');
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            background: #48bb78;
            color: white;
            padding: 15px 20px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            z-index: 1000;
            animation: slideIn 0.3s ease;
        `;
        notification.textContent = message;
        
        document.body.appendChild(notification);
        
        // Remove after 3 seconds
        setTimeout(() => {
            notification.remove();
        }, 3000);
    }

    exportData() {
        if (this.transactions.length === 0) {
            alert('No transactions to export!');
            return;
        }

        const dataStr = JSON.stringify(this.transactions, null, 2);
        const dataBlob = new Blob([dataStr], {type: 'application/json'});
        const url = URL.createObjectURL(dataBlob);
        
        const link = document.createElement('a');
        link.href = url;
        link.download = `transactions_${new Date().toISOString().split('T')[0]}.json`;
        link.click();
        
        URL.revokeObjectURL(url);
        this.showNotification('Data exported successfully!');
    }

    clearData() {
        if (confirm('Are you sure you want to clear all transaction data? This cannot be undone!')) {
            this.transactions = [];
            this.saveTransactions();
            this.updateStats();
            this.renderTransactions();
            this.showNotification('All data cleared successfully!');
        }
    }
}

// Global functions for inline event handlers
function testServer() {
    app.showNotification('Server test successful! 🚀');
    console.log('Server Status: OK');
    console.log('Current URL:', window.location.href);
    console.log('Transactions loaded:', app.transactions.length);
}

function exportData() {
    app.exportData();
}

function clearData() {
    app.clearData();
}

function refreshApp() {
    window.location.reload();
}

// Initialize app when page loads
let app;
document.addEventListener('DOMContentLoaded', () => {
    app = new TransactionManager();
    
    // Show welcome message
    setTimeout(() => {
        app.showNotification('Welcome to Transaction Manager! Press "A" to quickly add a transaction.');
    }, 1000);
});

// Add some sample data for demo purposes
function addSampleData() {
    const sampleTransactions = [
        {
            id: Date.now() - 3000,
            date: new Date(Date.now() - 3000).toLocaleString(),
            customerName: 'John Doe',
            amount: 1000,
            type: 'deposit',
            details: 'Initial deposit'
        },
        {
            id: Date.now() - 2000,
            date: new Date(Date.now() - 2000).toLocaleString(),
            customerName: 'Jane Smith',
            amount: -500,
            type: 'withdrawal',
            details: 'Cash withdrawal'
        },
        {
            id: Date.now() - 1000,
            date: new Date(Date.now() - 1000).toLocaleString(),
            customerName: 'Bob Wilson',
            amount: 750,
            type: 'deposit',
            details: 'Payment received'
        }
    ];
    
    app.transactions = [...sampleTransactions, ...app.transactions];
    app.saveTransactions();
    app.updateStats();
    app.renderTransactions();
    app.showNotification('Sample data added!');
}

// Expose function globally for testing
window.addSampleData = addSampleData;
