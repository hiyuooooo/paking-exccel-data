# 🧪 Testing Windows Package - Quick Guide

## Issue: White Page / App Not Loading

If you're seeing a **white page** instead of the Transaction Manager, here's how to fix it:

### 🔍 **Step 1: Test Development Mode First**

1. **Open Command Prompt** in the project folder
2. **Run:** `pnpm dev` (or `npm run dev`)
3. **Check:** Browser should open to `http://localhost:7020`
4. **Expected:** Full Transaction Manager interface

**If this works:** ✅ App is fine, problem is with production build
**If this fails:** ❌ Check Node.js installation and dependencies

---

### 🏗️ **Step 2: Test Production Build**

1. **Build the project:**

   ```cmd
   pnpm run build
   ```

2. **Check build output exists:**
   - `dist\spa\index.html` ✓
   - `dist\server\production.mjs` ✓
   - `dist\spa\assets\` folder with .js and .css files ✓

3. **Test production server:**
   ```cmd
   node dist\server\production.mjs
   ```
4. **Open browser to:** `http://localhost:3000`

**Expected:** Transaction Manager loads properly

---

### 🎯 **Step 3: Test Windows Package**

1. **Create package:**

   ```cmd
   build-windows.bat
   ```

2. **Go to package folder:**

   ```cmd
   cd windows-package
   ```

3. **Test the package:**
   ```cmd
   start.bat
   ```

**Expected:** Browser opens with working Transaction Manager

---

### 🔧 **Common Issues & Fixes**

#### **White Page - Assets Not Loading**

**Problem:** CSS/JS files not found
**Solution:**

- Check if `dist\spa\assets\` contains .js and .css files
- Verify server is serving static files correctly
- Try different browser or incognito mode

#### **"Cannot GET /" Error**

**Problem:** Server routing issue
**Solution:**

- Make sure `dist\server\production.mjs` exists
- Check if port 3000 is available
- Try running server directly: `node dist\server\production.mjs`

#### **Console Errors**

**Problem:** JavaScript errors preventing app load
**Solution:**

- Open browser console (F12)
- Look for red error messages
- Check if all assets loaded properly

#### **Port Already in Use**

**Problem:** Port 3000 or 7020 occupied
**Solution:**

- Close other applications
- Kill Node.js processes: `taskkill /f /im node.exe`
- Restart computer

---

### 🚀 **Quick Debug Commands**

```cmd
REM Check Node.js
node --version

REM Check if files exist
dir dist\spa\
dir dist\server\

REM Test production server
node dist\server\production.mjs

REM Check what's running on ports
netstat -an | findstr :3000
netstat -an | findstr :7020
```

---

### ✅ **Success Indicators**

**Development Working:**

- Command shows "ready in XXXms"
- Browser opens to localhost:7020
- Transaction Manager interface loads
- No console errors

**Production Working:**

- Server logs show "Server running on port 3000"
- Browser opens to localhost:3000
- Same Transaction Manager interface
- Assets load correctly

**Package Working:**

- `start.bat` launches without errors
- Browser opens automatically
- Full app functionality available
- No missing files or errors

---

### 📞 **Still Not Working?**

1. **Check browser console** (F12) for errors
2. **Try different browser** (Chrome, Firefox, Edge)
3. **Run as Administrator** if permission issues
4. **Disable antivirus** temporarily if blocking
5. **Clear browser cache** (Ctrl+F5)

### 📋 **Report Format**

If still having issues, please share:

- **OS:** Windows version
- **Node.js version:** `node --version`
- **Browser:** Which browser and version
- **Error messages:** Exact text from console
- **Steps taken:** What you tried
- **Expected vs Actual:** What should happen vs what happens

This helps identify the exact problem quickly!
