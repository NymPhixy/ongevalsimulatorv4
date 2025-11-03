# VR Functionaliteit - Quest 2

## ✅ Geïmplementeerde Features

### 1. **VR Controller Support**

- **Linker Controller**: Thumbstick locomotion voor beweging
  - Vooruit/achteruit: thumbstick omhoog/omlaag
  - Links/rechts: thumbstick links/rechts
  - Beweging is relatief aan kijkrichting
- **Rechter Controller**: Raycaster voor interacties
  - Laser pointer wijst naar objecten
  - Trigger knop om te interacteren met:
    - Veiligheidsmarkers (gele ballen)
    - EHBO items (spray & pleister)
    - Telefoon interface knoppen
    - Quiz antwoord knoppen

### 2. **3D UI in VR**

- **Panels**: Alle instructies en vragen verschijnen als 3D panels in de wereld
- **Telefoon**: 3D virtuele telefoon met werkend nummertoetsenbord
- **Quiz**: 3D antwoordknoppen zweven voor je in de ruimte
- **Hover effects**: Objecten lichten op wanneer je erop richt

### 3. **Interacties**

- **Geen gaze meer**: Alle interacties via trigger knop rechter controller
- **Pick-up systeem**: Items verschijnen aan rechter controller wanneer opgepakt
- **Visual feedback**: Objecten veranderen van kleur bij hover en selectie

## 🎮 Hoe te gebruiken

### Quick Start - VR Knop:

**De gemakkelijkste manier om VR te starten:**

1. Open de applicatie in je browser (Quest Browser of Desktop)
2. Klik op de **paarse "Start VR" knop** rechtsonder in het scherm
3. De VR-modus start automatisch (je headset moet aangesloten zijn)
4. Klik nogmaals (nu "Exit VR") om VR te verlaten

### Op Quest 2:

1. **Start de dev server**:

   ```powershell
   npm run dev:quest
   ```

2. **Connect Quest 2**:

   - Sluit Quest 2 aan via USB
   - Zet Developer Mode aan
   - ADB port forwarding wordt automatisch uitgevoerd

3. **Open in Quest Browser**:

   - Open browser in Quest
   - Ga naar: `http://localhost:5173`
   - Druk op de VR knop rechtsonder

4. **Controls in VR**:
   - **Linker thumbstick**: Lopen (vooruit/achteruit/zijwaarts)
   - **Rechter trigger**: Klikken op objecten
   - **Hoofdbeweging**: Rondkijken

### Desktop Mode:

- WASD: Lopen
- Muis: Kijken
- Klik: Interacteren

## 📋 Scenario Stappen in VR

1. **Stap 1**: Richt laser op gele markers (links & rechts), druk trigger
2. **Stap 2**: Beantwoord vraag met trigger op 3D knoppen
3. **Stap 3**: Gebruik 3D telefoon - toets 112, druk trigger op BELLEN
4. **Stap 4**: Loop naar EHBO items, richt laser, druk trigger om op te pakken
5. **Stap 5**: Richt op slachtoffer, trigger om items te gebruiken
6. **Stap 6**: Volg instructies tot einde

## 🔧 Technische Details

### Componenten:

- `thumbstick-locomotion`: Smooth locomotion met linker controller
- `vr-interactor`: Trigger-based interacties met rechter controller
- `pickable`: Items kunnen opgepakt en vastgehouden worden
- `glow`: Visual feedback voor interactieve objecten

### Classes:

- `.interactable`: Objecten die met raycaster kunnen interacteren
- `.gazeTarget`: Veiligheidsmarkers
- `.phone-btn-vr`: 3D telefoon en UI knoppen

### Raycaster instellingen:

- Bereik: 10 meter
- Targets: `.interactable`, `.gazeTarget`, `.phone-btn-vr`
- Visual laser: Cyaan kleur

## 🐛 Troubleshooting

**VR knop werkt niet?**

- Zorg dat je HTTPS gebruikt of localhost
- Check of Quest in Developer Mode staat

**Controllers niet zichtbaar?**

- Quest 2 gebruikt Oculus Touch controllers
- Zorg dat tracking aan staat

**Locomotion werkt niet?**

- Beweeg thumbstick volledig (deadzone bij >0.2)
- Check of linker controller goed getracked wordt

**Trigger doet niks?**

- Zorg dat laser op een `.interactable` object wijst
- Objecten moeten zichtbaar zijn
- Check console voor errors

## 📝 Ontwikkel Notities

- A-Frame versie: 1.7.1
- WebXR support ingebouwd
- Locomotion snelheid: 0.05 (aanpasbaar in component)
- Panel afstand: 4.5m voor de speler
- Telefoon positie: (0, 1.5, 4) - centraal voor speler
