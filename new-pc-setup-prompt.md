# Prompt for Claude Code on the new PC

Paste the following into Claude Code on the new computer:

---

I'm setting up a new Fedora Sway workstation. The following is already done:

- fspi install script ran (packages, flatpaks, sway/waybar/wezterm/dunst configs, zsh, oh-my-zsh, docker, mise, vpn-slice, fonts, aliases, scripts)
- SSH keys copied to ~/.ssh/ (need chmod check)
- .gitconfig copied to ~/
- .docker/ copied to ~/
- CETIN CA certs copied to ~/certs/ (root_CA_CETIN_23.crt, sub_CA_CETIN_23.crt, cetin-old.crt, complete-with-defaults.crt)
- VPN certs copied to ~/certs/ (vpn-cetin-new.crt.pem, vpn-cetin-new.key.pem)
- VPN script at ~/scripts/vpn-cetin.sh (paths already updated)
- VPN is working
- Makalu repo cloned to ~/projects/makalu
- Vivaldi synced

Please complete the remaining setup steps. Do each one and confirm before moving to the next:

1. **SSH permissions**: Ensure `~/.ssh/` is 700 and `~/.ssh/id_rsa` is 600.

2. **Git identity**: Create `~/.gitconfig.d/custom` with:
   ```
   [user]
       name = Jakub Hesoun
       email = jakub.hesoun@cetin.cz
   ```
   Verify the email is correct by checking git log in ~/projects/makalu.

3. **CETIN CA certs into system trust store** (Fedora uses /etc/pki):
   ```bash
   sudo cp ~/certs/root_CA_CETIN_23.crt ~/certs/sub_CA_CETIN_23.crt /etc/pki/ca-trust/source/anchors/
   sudo update-ca-trust
   ```

4. **Java truststore**: Add CETIN certs to Java's cacerts. Find JAVA_HOME via `mise where java` or check `${JAVA_HOME}`. Run:
   ```bash
   keytool -import -alias cetin-ca-23 -keystore ${JAVA_HOME}/lib/security/cacerts -file ~/certs/root_CA_CETIN_23.crt -storepass changeit -noprompt
   keytool -import -alias cetin-ca-sub-23 -keystore ${JAVA_HOME}/lib/security/cacerts -file ~/certs/sub_CA_CETIN_23.crt -storepass changeit -noprompt
   keytool -import -alias cetin-ca-old -keystore ${JAVA_HOME}/lib/security/cacerts -file ~/certs/cetin-old.crt -storepass changeit -noprompt
   ```

5. **Docker certs for Harbor**:
   ```bash
   sudo mkdir -p /etc/docker/certs.d/harbor.cetin
   sudo cp ~/certs/root_CA_CETIN_23.crt ~/certs/sub_CA_CETIN_23.crt /etc/docker/certs.d/harbor.cetin/
   sudo systemctl restart docker
   ```

6. **Mise — install languages**: Run `cd ~/projects/makalu && mise install`. If there's no .mise.toml or .tool-versions, install Java 21 and Node 20:
   ```bash
   mise use --global java@21
   mise use --global node@20
   ```

7. **Makalu secrets**: Create from templates:
   ```bash
   cd ~/projects/makalu
   cp common/src/main/resources/application-secrets.properties.template common/src/main/resources/application-secrets.properties
   cp docker-compose/backend.env.template docker-compose/backend.env
   ```
   Then tell me to fill in the credentials (ask colleagues).

8. **UI .env.local**: Create `~/projects/makalu/ui/.env.local`:
   ```
   NEXT_PUBLIC_AZURE_CLIENT_ID=
   NEXT_PUBLIC_AZURE_TENANT_ID=
   NEXT_PUBLIC_REDIRECT_URI=http://localhost:3000
   NEXT_PUBLIC_LOGIN_ALLOWED_ROLES=WGIS_Production_PortalWGIS
   ```
   Tell me to fill in client ID and tenant ID from colleagues.

9. **Fix .zshrc**: In `~/.zshrc`, replace any `/home/milan/` path with `/home/hesounj/` (the mise activate line).

10. **Docker compose test**: Verify the project starts:
    ```bash
    cd ~/projects/makalu && docker compose up -d
    ```
    Wait for postgres and redis to be healthy.

11. **Fingerprint (optional)**: Ask if I want to set up fingerprint for swaylock. If yes, follow ~/projects/fspi/fingerprint-swaylock-setup.md.

12. **k9s plugin**: Create `~/.config/k9s/plugins.yaml` with modify-secret plugin:
    ```yaml
    plugins:
      edit-secret:
        shortCut: Ctrl-X
        confirm: false
        description: "Edit Decoded Secret"
        scopes:
          - secrets
        command: kubectl
        background: false
        args:
          - modify-secret
          - --namespace
          - $NAMESPACE
          - --context
          - $CONTEXT
          - $NAME
    ```
    Also install krew and modify-secret plugin:
    ```bash
    kubectl krew install modify-secret
    ```

13. **flatpak wayland**: Run `flatpak override --user --socket=wayland`

After completing all steps, tell me what still needs manual input (credentials, etc.) and what's fully done.
