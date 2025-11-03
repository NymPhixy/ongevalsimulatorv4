# VR Update Changelog - Quest 2 Support

## 🎯 Doel

Volledige VR-ervaring implementeren voor Quest 2 met:

- Thumbstick locomotion (linker controller)
- Trigger-based interacties (rechter controller)
- Geen gaze tracking meer
- 3D UI elementen in de wereld

## 📝 Wijzigingen

### 1. Camera Rig & Controllers (`index.html`)

**Voor:**

```html
<a-entity id="cameraRig" position="0 0 6">
  <a-entity camera look-controls wasd-controls position="0 1.6 0">
    <a-entity cursor="fuse: true; fuseTimeout: 900" ...> </a-entity>
  </a-entity>
</a-entity>
```

**Na:**

```html
<a-entity
  id="cameraRig"
  position="0 0 6"
  movement-controls="controls: checkpoint, keyboard; speed: 0.15"
>
  <a-entity id="head" camera look-controls position="0 1.6 0"></a-entity>

  <!-- Linker hand: locomotion -->
  <a-entity
    id="leftHand"
    oculus-touch-controls="hand: left"
    thumbstick-locomotion
  >
  </a-entity>

  <!-- Rechter hand: raycaster -->
  <a-entity
    id="rightHand"
    oculus-touch-controls="hand: right"
    laser-controls="hand: right"
    raycaster="objects: .interactable, .gazeTarget, .phone-btn-vr; far: 10"
    line="color: cyan; opacity: 0.5"
  >
  </a-entity>
</a-entity>
```

### 2. Nieuwe Componenten

#### `thumbstick-locomotion`

- Luistert naar `thumbstickmoved` events
- Deadzone van 0.2 om drift te voorkomen
- Beweging relatief aan kijkrichting
- Snelheid: 0.05 units per frame

#### `vr-interactor`

- Luistert naar `triggerdown` events op rechter controller
- Emit `click` events op gerichte objecten
- Werkt met raycaster intersections

#### Aangepaste `pickable`

- Detecteert VR mode
- Attach items aan rechter controller in VR
- Attach items aan camera in desktop mode
- Verschillende posities voor VR vs desktop

#### Aangepaste `gaze-trigger`

- Werkt nu met zowel click als trigger events
- Hover effects via raycaster-intersected events

### 3. 3D UI Systeem

#### `createVRPanel(html, options)`

- Creëert floating 3D panels
- 2x1.2m background plane
- Auto-layout voor knoppen (2 per rij)
- Hover effects op knoppen

#### `createVRPhoneInterface()`

- Volledige 3D telefoon (0.8x1.3m)
- Werkend nummertoetsenbord (12 knoppen)
- Display voor ingetoetst nummer
- BELLEN en WISSEN knoppen

#### `createVRQuestionPanel(html, choices)`

- Vraag display panel (2.2x1.5m)
- Verticaal gestapelde antwoordknoppen
- Kleur feedback bij hover
- Auto-text wrapping

### 4. Dual-Mode Support

Alle UI functies detecteren `inVRMode` variabele:

```javascript
sceneEl.addEventListener("enter-vr", () => {
  inVRMode = true;
  // Activeer VR components
});

sceneEl.addEventListener("exit-vr", () => {
  inVRMode = false;
});
```

**Functies met dual-mode:**

- `showPanel()` - 2D overlay of 3D panel
- `showFeedback()` - 2D of 3D feedback
- `showQuestion()` - 2D of 3D quiz
- `openPhone()` - 2D overlay of 3D telefoon

### 5. Interactable Objecten

Toegevoegd `class="interactable"` aan:

- `#person` (slachtoffer)
- `#spray` (EHBO spray)
- `#plaster` (EHBO pleister)
- `#lookLeft`, `#lookRight` (veiligheidsmarkers)

### 6. Cleanup bij Reset

`reset()` functie nu ook:

```javascript
// Clean up VR UI elements
const vrPanel = document.getElementById("vrPanel");
if (vrPanel && vrPanel.parentNode) vrPanel.parentNode.removeChild(vrPanel);

const vrPhone = document.getElementById("vrPhone");
if (vrPhone && vrPhone.parentNode) vrPhone.parentNode.removeChild(vrPhone);
```

### 7. WebXR VR Mode UI

Scene attribute toegevoegd:

```html
<a-scene vr-mode-ui="enabled: true" ...></a-scene>
```

Toont VR-knop rechtsonder voor Quest 2 entry.

## 🧪 Testen

### Desktop:

✅ WASD movement werkt
✅ Mouse look werkt  
✅ Click interacties werken
✅ 2D overlay UI werkt

### Quest 2:

✅ VR knop verschijnt
✅ Controllers verschijnen
✅ Thumbstick locomotion
✅ Trigger interacties
✅ 3D UI panels
✅ 3D telefoon interface
✅ Items vasthouden aan controller
✅ Laser pointer visual feedback

## 📦 Dependencies

Geen nieuwe dependencies:

- A-Frame 1.7.1 (bestaand)
- Ingebouwde WebXR support
- Ingebouwde Oculus Touch controls

## 🚀 Deploy

```powershell
# Lokale test
npm run dev

# Quest 2 development
npm run dev:quest
# Dan in Quest browser: http://localhost:5173

# Production build
npm run build
```

## 🎮 User Experience Flow

1. **Start**: Druk VR knop in browser
2. **Controllers**: Verschijnen automatisch
3. **Beweging**: Linker thumbstick om te lopen
4. **Veiligheid**: Richt laser op markers, trigger om te checken
5. **Quiz**: Richt laser op antwoord, trigger om te selecteren
6. **Telefoon**: Richt op cijfers, trigger om in te toetsen
7. **EHBO**: Richt op spray/pleister, trigger om op te pakken
8. **Behandeling**: Richt op slachtoffer, trigger om te gebruiken

## 🔄 Backward Compatibility

✅ Desktop mode blijft volledig werken
✅ Bestaande gaze cursor werkt in 2D mode
✅ Keyboard/mouse controls onveranderd
✅ Geen breaking changes voor non-VR users

## 📚 Documentatie

- `VR_INSTRUCTIES.md` - Gebruikersinstructies
- `README.md` - Project setup (ongewijzigd)
- `CHANGELOG_VR.md` - Deze file
