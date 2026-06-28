<div align="center">
<pre>
███████╗██╗  ██╗██████╗  ██████╗  ██████╗    ███████╗██╗      ██████╗ ██╗    ██╗ 
██╔════╝╚██╗██╔╝╚════██╗██╔═══██╗██╔═══██╗    ██╔════╝██║     ██╔═══██╗██║    ██║
█████╗   ╚███╔╝  █████╔╝██║   ██║██║   ██║    █████╗  ██║     ██║   ██║██║ █╗ ██║
██╔══╝   ██╔██╗ ██╔═══╝ ██║   ██║██║   ██║    ██╔══╝  ██║     ██║   ██║██║███╗██║
███████╗██╔╝ ██╗███████╗╚██████╔╝╚██████╔╝    ██║     ███████╗╚██████╔╝╚███╔███╔╝
╚══════╝╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚═════╝    ╚═╝     ╚══════╝ ╚═════╝  ╚══╝╚══╝  
                        ██╗      ██████╗ ██████╗ ███████╗                        
                        ██║     ██╔══██╗██╔══██╗██╔════╝                         
                        ██║     ███████║██████╔╝███████╗                         
                        ██║     ██╔══██║██╔══██╗╚════██║                         
                        ███████╗██║  ██║██████╔╝███████║                         
                        ╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝                         
</pre>
</div>
<p align="center">
  <a href="https://www.redhat.com/en/services/training/ex200-red-hat-certified-system-administrator-exam">
    <img src="https://img.shields.io/badge/Exam-RHCSA%20EX200-red?style=for-the-badge&logo=redhat" alt="RHCSA-EX200" />
  </a>
  <a href="https://almalinux.org/">
    <img src="https://img.shields.io/badge/RHEL-9%20Compatible-red?style=for-the-badge&logo=redhat" alt="RHEL-Version" />
  </a>
  <a href="https://www.vagrantup.com/">
    <img src="https://img.shields.io/badge/Environment-Vagrant%20%2B%20Hyper--V-blue?style=for-the-badge&logo=vagrant" alt="Vagrant" />
  </a>
  <a href="https://github.com/github/spec-kit">
    <img src="https://img.shields.io/badge/Language-Espa%C3%B1ol-green?style=for-the-badge" alt="Language" />
  </a>
</p>

> **"Con la rima en la mente y los comandos en la shell, pasar el EX200 se vuelve un nivel fácil de vencer."**

`ex200-flow-labs` es un entorno interactivo y automatizado de aprendizaje diseñado en español para dominar el examen **Red Hat Certified System Administrator (RHCSA EX200)** basado en **Red Hat Enterprise Linux 9 (RHEL 9)**. 

Este proyecto utiliza **Vagrant con Hyper-V** para ofrecer laboratorios rápidos y aislados, y añade un enfoque mnemotécnico único: **canciones de rap técnico en español** para memorizar comandos complejos y sus flags específicos de forma divertida y permanente.

---

## 📚 Temas Cubiertos en los Labs

Este entorno de laboratorios cubre el 100% de los objetivos oficiales del examen RHCSA (EX200):

1. **Herramientas Esenciales:** Consola, edición de archivos, comandos básicos y redirecciones.
2. **Scripts de Automatización:** Fundamentos y prácticas de Shell Scripting en Bash.
3. **Operación del Sistema:** Control de servicios con systemd, GRUB y recuperación de contraseña de root.
4. **Usuarios y Grupos:** Gestión de identidades, permisos especiales (SUID, SGID, Sticky Bit) y ACLs.
5. **Servicios de Red:** Configuración con nmcli, sincronización de hora con chrony y tareas programadas con Cron.
6. **Seguridad y SELinux:** Gestión de firewalld y modos, contextos y políticas de SELinux.
7. **Almacenamiento Local:** Gestión de particiones, volúmenes lógicos (LVM) y optimización.
8. **Sistemas de Archivos en Red:** Montajes estáticos en `/etc/fstab`, NFS, SMB y montajes dinámicos con Autofs.
9. **Contenedores:** Despliegue de contenedores Rootless y persistencia de servicios mediante systemd con Podman.

---

## ⚡ El Flujo de Estudio ("The Flow")

Cada laboratorio cuenta con una metodología estricta de cinco pasos estructurada bajo principios de desarrollo ágil:

```mermaid
graph TD
    A[1. Entender: demo.sh] --> B[2. Practicar: instructions.md]
    B --> C[3. Evaluar: verify.sh]
    C -- FAILED --> D[Pistas: hints.md / Reiniciar: reset.sh]
    D --> B
    C -- PASSED --> E[4. Memorizar: Rap Lyrics]
    E --> F[¡Siguiente Tema!]
```

1.  **`demo.sh` (La Demo Visual):** Corre el script de tutorial animado dentro de la VM para ver los comandos en acción.
2.  **`instructions.md` (El Reto):** Lee las directrices del challenge redactadas en español (pero conservando comandos en inglés).
3.  **`verify.sh` (El Validador):** Ejecuta el validador automatizado para autoevaluar tu entrega. Te dará un reporte visual de `PASSED`/`FAILED` sin alterar tus configuraciones.
4.  **`reset.sh` (El Reinicio):** ¿Cometiste un error crítico? Ejecuta el reset para limpiar la práctica y volver a empezar.
5.  **`hints.md` (Las Pistas):** Consulta pistas progresivas si te encuentras estancado.

---

## 🛠️ Configuración e Instalación Rápida (Paso a Paso)

Para que puedas correr estos laboratorios de forma local, utilizaremos un entorno nativo: **Windows 10/11** actuará como el hipervisor físico (mediante **Hyper-V**) y ejecutarás los comandos de Vagrant desde tu consola de comandos (PowerShell, CMD, o Git Bash).

Sigue esta guía narrativa sencilla para preparar tu computadora en 10 minutos:

### 1. Activar Hyper-V en tu Windows
Hyper-V es la tecnología nativa de virtualización de Windows. Necesitamos activarla:
1. Abre el menú Inicio de Windows, escribe **PowerShell**, haz clic derecho sobre él y selecciona **Ejecutar como Administrador**.
2. Copia, pega y ejecuta el siguiente comando:
   ```powershell
   Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
   ```
3. Si el sistema te solicita reiniciar para aplicar los cambios, acepta y reinicia tu equipo.

### 2. Instalar Vagrant en Windows
Vagrant es la herramienta que creará y configurará la máquina virtual por nosotros:
1. Ve al sitio oficial de descargas de [Vagrant](https://www.vagrantup.com/downloads) y descarga el instalador para Windows (arquitectura AMD64/x86_64).
2. Ejecuta el instalador descargado y sigue el asistente haciendo clic en "Next" hasta finalizar.

---

## 🚀 Cómo Iniciar y Usar el Laboratorio

Una vez realizada la instalación inicial, el uso diario es sumamente rápido:

### Paso A: Clonar el proyecto
Abre la terminal de **PowerShell** en tu Windows 10/11 y clona este repositorio (requiere tener **Git** instalado en Windows) en un directorio nativo (por ejemplo, `C:\proys\`):
```powershell
git clone https://github.com/hooperits/ex200-flow-labs.git
cd ex200-flow-labs
```

### Paso B: Encender la Máquina Virtual
Inicia la máquina AlmaLinux 9 de estudio desde tu consola (PowerShell o Git Bash) con privilegios de Administrador (requerido para Hyper-V):
```powershell
vagrant up --provider=hyperv
```

### Paso C: Entrar a la Máquina de Estudio
Accede a la consola de la máquina virtual vía SSH:
```powershell
vagrant ssh
```
Dentro de la máquina virtual (que es un entorno Linux puro), podrás navegar al directorio `/labs/` donde encontrarás el laboratorio actual listo para ejecutar la demo o realizar el challenge:
```bash
cd /labs/
```

> [!TIP]
> **Sincronización de Archivos**:
> Si realizas algún cambio en las instrucciones o scripts de la carpeta `./labs/` desde el host (Windows), puedes sincronizarlos con la máquina virtual ejecutando:
> ```powershell
> vagrant provision
> ```

