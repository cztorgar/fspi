# Sway + Fedora - Manuál pro rychlý start

## Obsah

- [Sway - klávesové zkratky](#sway---klávesové-zkratky)
- [Přepínání klávesnice](#přepínání-klávesnice)
- [Screenshoty](#screenshoty)
- [Rofi - spouštěč aplikací](#rofi---spouštěč-aplikací)
- [Terminál - WezTerm](#terminál---wezterm)
- [Nainstalované aplikace](#nainstalované-aplikace)
- [Aliasy v terminálu](#aliasy-v-terminálu)
- [Nástroje příkazové řádky](#nástroje-příkazové-řádky)
- [VPN](#vpn)
- [Clipboard](#clipboard)

---

## Sway - klávesové zkratky

`$mod` = Super (Windows klávesa)

### Základní

| Zkratka | Akce |
|---------|------|
| `Super + Enter` | Nový terminál (WezTerm) |
| `Super + Space` | Spouštěč aplikací (rofi) |
| `Super + w` | Zavřít okno |
| `Super + l` | Zamknout obrazovku (swaylock) |
| `Super + f` | Fullscreen |
| `Super + Escape` | Menu: shutdown/restart/suspend/lock |
| `Super + Shift + r` | Reload sway configu |
| `Super + Shift + e` | Odhlásit se ze Sway |

### Navigace mezi okny

| Zkratka | Akce |
|---------|------|
| `Super + šipky` | Přepnutí focusu na okno vlevo/dole/nahoře/vpravo |
| `Super + Shift + šipky` | Přesun okna vlevo/dole/nahoře/vpravo |
| `Alt + Tab` | Focus na další sourozenecké okno |
| `Alt + Shift + Tab` | Focus na předchozí sourozenecké okno |
| `Super + a` | Focus na rodičovský kontejner |

### Workspaces (virtuální plochy)

| Zkratka | Akce |
|---------|------|
| `Super + 1-9, 0` | Přepnout na workspace 1-10 |
| `Super + Shift + 1-9, 0` | Přesunout okno na workspace 1-10 |
| `Super + Tab` | Přepnout mezi posledními dvěma workspaces |

### Layout (rozmístění oken)

| Zkratka | Akce |
|---------|------|
| `Super + h` | Horizontální split (další okno vedle) |
| `Super + b` | Vertikální split (další okno pod) |
| `Super + e` | Toggle split orientace |
| `Super + s` | Stacking layout (okna na sobě, záložky nahoře) |
| `Super + t` | Tabbed layout (jako záložky v prohlížeči) |
| `Super + Shift + p` | Toggle floating (plovoucí okno) |
| `Super + p` | Přepnout focus mezi tiling a floating okny |

### Resize mód

| Zkratka | Akce |
|---------|------|
| `Super + r` | Vstup do resize módu |
| šipky (v resize módu) | Změna velikosti okna |
| `Enter` nebo `Escape` | Ukončení resize módu |

### Scratchpad (skrytá okna)

| Zkratka | Akce |
|---------|------|
| `Super + Shift + -` | Schovat okno do scratchpadu |
| `Super + -` | Zobrazit/cyklovat okna ze scratchpadu |

### Clipboard

| Zkratka | Akce |
|---------|------|
| `Super + c` | Kopírovat (ekvivalent Ctrl+Insert) |
| `Super + v` | Vložit (ekvivalent Shift+Insert) |
| `Ctrl + Super + v` | Historie clipboardu (rofi picker) |

### Aplikace

| Zkratka | Akce |
|---------|------|
| `Super + i` | Otevřít ChatGPT (webapp) |
| `Super + Shift + i` | Otevřít Gemini (webapp) |
| `Super + /` | Zobrazit aktuální Spotify track |
| `Super + ,` | Zavřít notifikaci (dunst) |

---

## Přepínání klávesnice

Rozložení: **US** a **CZ QWERTY**

Přepínání: **stisk obou Ctrl najednou** (levý + pravý Ctrl)

---

## Screenshoty

| Zkratka | Akce |
|---------|------|
| `Print Screen` | Výběr oblasti (region) |
| `Alt + Print Screen` | Screenshot okna |
| `Ctrl + Print Screen` | Celá obrazovka |

Průběh: wayfreeze zmrazí obraz -> slurp vybere oblast -> grim vyfotí -> satty otevře editor (kreslit, ořezat) -> Enter uloží do clipboardu + souboru do `~/Pictures/Screenshots/`.

---

## Rofi - spouštěč aplikací

Otevři: `Super + Space`

Začni psát název aplikace, šipkami vyber, Enter spustí. Zobrazuje všechny nainstalované aplikace (s .desktop souborem).

Tipy:
- Funguje i jako kalkulačka: napiš `qalc` a otevře se Qalculate
- `Ctrl + Super + v` otevře historii clipboardu v rofi
- `Super + Escape` otevře shutdown/restart menu v rofi

---

## Terminál - WezTerm

Terminál běží jako Flatpak. Spustí se přes `Super + Enter`.

Konfigurace: `~/.config/wezterm/wezterm.lua`

---

## Nainstalované aplikace

### GUI (Flatpak)

| Příkaz / Alias | Aplikace | K čemu |
|----------------|----------|--------|
| `idea` | IntelliJ IDEA Ultimate | Java/Kotlin IDE |
| `obsidian` | Obsidian | Poznámky (Markdown) |
| `teams` | Teams for Linux | Firemní komunikace |
| `spotify` | Spotify | Hudba |
| `zapzap` / `whatsapp` | ZapZap | WhatsApp klient |
| `bitwarden` | Bitwarden | Správce hesel |
| `pinta` | Pinta | Jednoduchý grafický editor |
| `wezterm` | WezTerm | Terminálový emulátor |
| (rofi) | draw.io | Diagramy |
| (rofi) | Zed | Textový editor |

### GUI (DNF)

| Aplikace | K čemu |
|----------|--------|
| Vivaldi | Webový prohlížeč (výchozí) |
| Chromium | Záložní prohlížeč |
| LibreOffice | Kancelářský balík |
| Inkscape | Vektorová grafika |
| Xournal++ | Poznámky / anotace PDF |
| Okular | Prohlížeč PDF |
| Meld | Vizuální porovnání souborů (diff) |
| Qalculate | Kalkulačka (GUI: qalculate-qt, CLI: qalc) |
| mpv | Video přehrávač |
| feh | Prohlížeč obrázků |

---

## Aliasy v terminálu

Definovány v `~/.aliases`, automaticky načítány v zsh i bash.

```
teams       → Teams for Linux
spotify     → Spotify
zapzap      → ZapZap (WhatsApp)
whatsapp    → ZapZap
vivaldi     → Vivaldi
bitwarden   → Bitwarden
idea        → IntelliJ IDEA
obsidian    → Obsidian
pinta       → Pinta
wezterm     → WezTerm
k           → kubectl
open        → xdg-open (otevři soubor výchozí aplikací)
```

---

## Nástroje příkazové řádky

### mise - správce verzí jazyků a nástrojů

Nahrazuje nvm, sdkman, pyenv atd. Jeden nástroj pro správu verzí Java, Node, Python...

```bash
# Instalace jazyka/toolu
mise install java@21          # nainstaluje Javu 21
mise install node@20          # nainstaluje Node 20

# Nastavení globální verze
mise use --global java@21
mise use --global node@20

# Nastavení verze pro aktuální projekt (vytvoří .mise.toml)
mise use java@21

# Zobrazit nainstalované verze
mise list

# Zobrazit dostupné verze
mise list-all java

# Aktualizace
mise upgrade
```

Konfigurace: `~/.config/mise/config.toml`
Shimmy (binárky): `~/.local/share/mise/shims/` (přidáno do PATH)

### mc - Midnight Commander

Dvoupanelový souborový manažer v terminálu.

```bash
mc                    # spustit
```

Klávesy:
- `Tab` — přepnout panely
- `F5` — kopírovat
- `F6` — přesunout
- `F7` — nový adresář
- `F8` — smazat
- `F3` — zobrazit soubor
- `F4` — editovat soubor
- `F10` — ukončit
- `Alt + c` — quick cd (zadat cestu)
- `Ctrl + o` — toggle mezi mc a terminálem

### btop / htop - systémový monitor

```bash
btop    # hezčí, interaktivní
htop    # klasika
```

### k9s - Kubernetes TUI

Terminálové rozhraní pro správu Kubernetes clusterů.

```bash
k9s                        # spustit (použije aktuální kubectl context)
k9s --context muj-cluster  # konkrétní cluster
```

Klávesy:
- `:` — příkazový řádek (napiš typ zdroje: `pods`, `svc`, `deploy`, `secrets`...)
- `/` — filtrovat
- `Enter` — detail
- `l` — logy
- `s` — shell do podu
- `d` — describe
- `Ctrl + x` — edit decoded secret (plugin)
- `Ctrl + d` — smazat
- `Escape` — zpět

### glab - GitLab CLI

```bash
glab mr list              # seznam merge requestů
glab mr create            # nový MR
glab mr view 123          # detail MR
glab mr checkout 123      # checkout MR branch
glab issue list           # seznam issues
```

### jq / yq - JSON/YAML procesor

```bash
cat file.json | jq '.key'           # vytáhni hodnotu
cat file.json | jq '.items[].name'  # iteruj pole
cat file.yaml | yq '.key'           # totéž pro YAML
```

### calcurse - terminálový kalendář

```bash
calcurse    # spustit
```

Podporuje CalDAV sync (konfig: `~/.config/calcurse/caldav/config`).

### fzf - fuzzy finder

Interaktivní vyhledávání v terminálu.

```bash
# Vyhledávání v historii příkazů
Ctrl + r

# Hledání souborů
vim $(fzf)

# Pipe cokoliv
cat file.txt | fzf
```

### autojump (z) - rychlá navigace

Pamatuje si adresáře, do kterých chodíš, a skáče do nich.

```bash
z makalu      # skočí do ~/projects/makalu (nebo nejbližší shoda)
z ui          # skočí do posledního adresáře obsahujícího "ui"
```

Funguje automaticky po chvíli používání `cd` — učí se z tvé historie.

### ocrmypdf - OCR pro PDF

```bash
ocrmypdf input.pdf output.pdf           # přidá textovou vrstvu
ocrmypdf -l ces input.pdf output.pdf    # česky
```

### ddcutil - ovládání externího monitoru

```bash
ddcutil setvcp 10 70    # nastav jas na 70%
ddcutil getvcp 10       # zjisti aktuální jas
```

---

## VPN

CETIN VPN přes openconnect + vpn-slice (split tunnel — jen firemní provoz jde přes VPN).

```bash
sudo ~/scripts/vpn-cetin.sh
```

Pozor: script obsahuje cesty k certifikátům — uprav si je na svoje (`CERT`, `KEY`, `CAFILE` proměnné ve scriptu).

---

## Clipboard

Clipboard manager běží automaticky (clipman). Historie se ukládá.

| Akce | Jak |
|------|-----|
| Kopírovat | `Super + c` nebo `Ctrl + c` (v některých apps) |
| Vložit | `Super + v` nebo `Ctrl + v` |
| Historie | `Ctrl + Super + v` (rofi picker) |

V terminálu WezTerm: `Ctrl + Shift + c` / `Ctrl + Shift + v` (standardní terminálové zkratky).

---

## Notifikace (dunst)

Systém notifikací běží přes dunst.

| Zkratka | Akce |
|---------|------|
| `Super + ,` | Zavřít poslední notifikaci |

Konfigurace: `~/.config/dunst/dunstrc`

Ruční odeslání notifikace (pro testování):
```bash
notify-send "Titulek" "Text zprávy"
```

---

## Zsh - tipy

Oh-My-Zsh s pluginy:
- **zsh-syntax-highlighting** — barevné zvýraznění příkazů při psaní
- **zsh-autosuggestions** — šedý návrh z historie (doprav šipkou vpravo)
- **fzf** — `Ctrl + r` pro fuzzy hledání v historii
- **autojump / z** — `z nazev` pro rychlé skákání do adresářů
- **git plugin** — zkratky: `gst` (status), `gco` (checkout), `gp` (push), `gl` (pull)
- **kubectl plugin** — `k get pods` atd.

---

## Systémové menu (Super + Escape)

Rofi menu s možnostmi:
- Lock (swaylock)
- Screensaver
- Suspend
- Restart
- Shutdown

---

## Užitečné příkazy

```bash
# Zjistit název monitoru (pro sway config)
swaymsg -t get_outputs

# Zjistit app_id okna (pro sway rules)
swaymsg -t get_tree | jq '.. | objects | select(.focused) | {app_id, class, title}'

# WiFi
nmtui                                              # GUI v terminálu
nmcli device wifi connect "SSID" password "heslo"  # z příkazové řádky

# Bluetooth
bluetoothctl
  scan on
  pair XX:XX:XX:XX:XX:XX
  connect XX:XX:XX:XX:XX:XX

# Audio
wpctl status          # zobraz audio zařízení
wpctl set-volume @DEFAULT_AUDIO_SINK@ 50%   # nastav hlasitost
```
