# Netlify Deployment Guide

## 🚀 Deploy naar Netlify

Dit project is geoptimaliseerd voor deployment op Netlify met Node.js 20 LTS.

### ✅ Configuratie

Het project bevat de volgende configuratiebestanden voor Netlify:

1. **`netlify.toml`** - Netlify build configuratie
2. **`.nvmrc`** - Node versie specificatie (20 LTS)
3. **`package.json`** - Engines veld voor Node >=18.0.0

### 📋 Deployment Stappen

#### Optie 1: Via Netlify Dashboard (Aanbevolen)

1. **Login bij Netlify**: https://app.netlify.com
2. **Klik op "Add new site" → "Import an existing project"**
3. **Connect je GitHub repository**:
   - Selecteer `NymPhixy/ongevalsimulatorv4`
   - Selecteer branch: `ongevalsimulatorprototypevr`
4. **Build settings** (automatisch ingevuld via netlify.toml):
   - Build command: `npm run build`
   - Publish directory: `dist`
   - Node version: `20`
5. **Klik op "Deploy site"**

#### Optie 2: Via Netlify CLI

```bash
# Installeer Netlify CLI
npm install -g netlify-cli

# Login
netlify login

# Initialiseer en deploy
netlify init
netlify deploy --prod
```

### 🔧 Build Configuratie

**`netlify.toml` inhoud:**
```toml
[build]
  publish = "dist"
  command = "npm run build"

[build.environment]
  NODE_VERSION = "20"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
```

### 📦 Node.js Versies

- **Minimum**: Node 18.0.0
- **Netlify**: Node 20 LTS (geconfigureerd)
- **Development**: Node 20+ aanbevolen

### ⚙️ Environment Variables (Optioneel)

Als je environment variables nodig hebt:

1. Ga naar Site settings → Environment variables
2. Voeg toe wat nodig is

Voor dit project zijn geen environment variables nodig.

### 🌐 Custom Domain (Optioneel)

1. Ga naar Domain settings
2. Voeg je custom domain toe
3. Update DNS records volgens Netlify instructies

### 🔍 Build Logs Bekijken

Na deployment:
- Ga naar Deploys → Latest deploy
- Bekijk deploy logs voor troubleshooting

### ✨ Verwachte URL

Na deployment krijg je een URL zoals:
```
https://your-site-name.netlify.app
```

### 🎮 VR Functionaliteit op Netlify

**Belangrijk:** 
- WebXR (VR) werkt alleen via HTTPS
- Netlify biedt automatisch HTTPS ✅
- Test VR functionaliteit op Quest 2 via de Netlify URL

### 🐛 Troubleshooting

**Build faalt?**
- Check of Node versie 20 wordt gebruikt (staat in build logs)
- Controleer of alle dependencies geïnstalleerd zijn
- Bekijk build logs voor specifieke errors

**VR werkt niet?**
- Zorg dat je HTTPS gebruikt (Netlify doet dit automatisch)
- Test op een VR-compatibele browser
- Check browser console voor WebXR errors

**Site laadt niet correct?**
- Controleer of redirect rules werken (`/*` → `/index.html`)
- Bekijk Network tab in browser DevTools

### 📝 Continuous Deployment

Netlify zal automatisch rebuilden wanneer je pusht naar de `ongevalsimulatorprototypevr` branch:

```bash
git add .
git commit -m "Update VR features"
git push origin ongevalsimulatorprototypevr
```

Netlify detecteert de push en start automatisch een nieuwe build.

### 🔄 Preview Deployments

Elke Pull Request krijgt automatisch een preview URL voor testing.

## 📞 Support

- Netlify Docs: https://docs.netlify.com
- Netlify Support: https://www.netlify.com/support/
