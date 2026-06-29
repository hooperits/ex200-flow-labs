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

> **"Con los comandos en la shell, pasar el EX200 se vuelve un nivel fácil de vencer."**

`ex200-flow-labs` es un entorno interactivo y automatizado de aprendizaje diseñado en español para dominar el examen **Red Hat Certified System Administrator (RHCSA EX200)** basado en **Red Hat Enterprise Linux 9 (RHEL 9)**. 

Este proyecto utiliza **Vagrant con Hyper-V** para ofrecer laboratorios rápidos y aislados orientados a la práctica interactiva para el examen de certificación.

---

## 📚 Tabla de Contenidos de los Laboratorios

A continuación se detalla la lista de laboratorios disponibles. Haz clic en los enlaces para acceder directamente a las instrucciones, validadores, restauradores o pistas de cada reto práctico:

| Módulo | Tema del Laboratorio | Objetivos Evaluados (Resumen) | Guía de Reto (Challenge) | Evaluador | Restaurador | Pistas |
| :---: | :--- | :--- | :---: | :---: | :---: | :---: |
| **01** | Herramientas Esenciales | Enlaces blandos/duros, permisos octales `640`, filtros de texto con `grep` y `regex`. | [Ver Reto](labs/01-essential-tools/instructions.md) | [verify.sh](labs/01-essential-tools/verify.sh) | [reset.sh](labs/01-essential-tools/reset.sh) | [hints.md](labs/01-essential-tools/hints.md) |
| **02** | Shell Scripting | Variables, aritmética `$((A+B))`, condicionales `if/elif/else`, bucles `for/while` y control de parámetros. | [Ver Reto](labs/02-shell-scripting/instructions.md) | [verify.sh](labs/02-shell-scripting/verify.sh) | [reset.sh](labs/02-shell-scripting/reset.sh) | [hints.md](labs/02-shell-scripting/hints.md) |
| **03** | Operación de Sistemas | Archivos de servicio de systemd (`.service`), cambio de targets predeterminados y restauración de contraseña de root en GRUB (`rd.break`). | [Ver Reto](labs/03-operating-systems/instructions.md) | [verify.sh](labs/03-operating-systems/verify.sh) | [reset.sh](labs/03-operating-systems/reset.sh) | [hints.md](labs/03-operating-systems/hints.md) |
| **04** | Usuarios y Grupos | Creación de identidades, shells no interactivas (`/sbin/nologin`), permisos colaborativos SGID (`2770`) y ACLs (`setfacl`). | [Ver Reto](labs/04-users-groups/instructions.md) | [verify.sh](labs/04-users-groups/verify.sh) | [reset.sh](labs/04-users-groups/reset.sh) | [hints.md](labs/04-users-groups/hints.md) |
| **05** | Servicios de Red y Cron | Configuración de hostname, asignación de IP estática con `nmcli`, sincronización NTP con `chronyd` y tareas automatizadas en `crontab`. | [Ver Reto](labs/05-networking-services/instructions.md) | [verify.sh](labs/05-networking-services/verify.sh) | [reset.sh](labs/05-networking-services/reset.sh) | [hints.md](labs/05-networking-services/hints.md) |
| **06** | Seguridad y SELinux | Reglas permanentes y puertos en `firewalld`, cambio y restauración de contextos de archivos (`restorecon`/`semanage`) y booleanos de SELinux. | [Ver Reto](labs/06-security-selinux/instructions.md) | [verify.sh](labs/06-security-selinux/verify.sh) | [reset.sh](labs/06-security-selinux/reset.sh) | [hints.md](labs/06-security-selinux/hints.md) |
| **07** | Almacenamiento Local LVM | Inicialización de PVs, creación y redimensionamiento en caliente de VG/LV, formateo XFS/ext4 y volumen optimizado VDO. | [Ver Reto](labs/07-local-storage/instructions.md) | [verify.sh](labs/07-local-storage/verify.sh) | [reset.sh](labs/07-local-storage/reset.sh) | [hints.md](labs/07-local-storage/hints.md) |
| **08** | Sistemas de Archivos de Red | Montaje local persistente por UUID en `fstab`, montajes automáticos bajo demanda de NFS mediante mapas de Autofs. | [Ver Reto](labs/08-filesystems-network/instructions.md) | [verify.sh](labs/08-filesystems-network/verify.sh) | [reset.sh](labs/08-filesystems-network/reset.sh) | [hints.md](labs/08-filesystems-network/hints.md) |
| **09** | Contenedores Podman | Búsqueda y descarga de imágenes ubi9, inicio de contenedores en modo rootless con volumen local persistente (`:Z`), y servicios persistentes de usuario. | [Ver Reto](labs/09-podman-containers/instructions.md) | [verify.sh](labs/09-podman-containers/verify.sh) | [reset.sh](labs/09-podman-containers/reset.sh) | [hints.md](labs/09-podman-containers/hints.md) |

---

## ⚡ El Flujo de Estudio ("The Flow")

Cada laboratorio cuenta con una metodología estricta de cinco pasos estructurada bajo principios de desarrollo ágil:

```mermaid
graph TD
    A[1. Entender: demo.sh] --> B[2. Practicar: instructions.md]
    B --> C[3. Evaluar: verify.sh]
    C -- FAILED --> D[Pistas: hints.md / Reiniciar: reset.sh]
    D --> B
    C -- PASSED --> E[¡Siguiente Tema!]
```

1.  **`demo.sh` (La Demo Visual):** Corre el script de tutorial animado dentro de la VM para ver los comandos en acción.
2.  **`instructions.md` (El Reto):** Lee las directrices del challenge redactadas en español (pero conservando comandos en inglés).
3.  **`verify.sh` (El Validador):** Ejecuta el validador automatizado para autoevaluar tu entrega. Te dará un reporte visual de `PASSED`/`FAILED` sin alterar tus configuraciones.
4.  **`reset.sh` (El Reinicio):** ¿Cometiste un error crítico? Ejecuta el reset para limpiar la práctica y volver a empezar.
5.  **`hints.md` (Las Pistas):** Consulta pistas progresivas si te encuentras estancado.

---

## 🚀 Guía de Inicio Rápido (Paso a Paso)

Sigue este flujo cronológico ordenado para configurar tu entorno y ejecutar tu primer laboratorio en menos de 10 minutos.

### Paso 1: Clonar el proyecto
Primero, abre la terminal de **PowerShell** en tu Windows 10/11 y clona este repositorio en un directorio local de tu disco físico (por ejemplo, `C:\proys\`):
```powershell
# Nota: Requiere tener Git para Windows instalado
git clone https://github.com/hooperits/ex200-flow-labs.git
cd ex200-flow-labs
```

### Paso 2: Activar Hyper-V en Windows
Hyper-V es la tecnología nativa de virtualización de Windows. Para activarla:
1. Con la consola de **PowerShell** aún abierta, asegúrate de ejecutarla con privilegios de **Administrador**.
2. Copia y ejecuta el siguiente comando:
   ```powershell
   Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
   ```
3. Si el sistema te solicita reiniciar para aplicar los cambios, acepta y reinicia tu equipo.

### Paso 3: Instalar Vagrant
Vagrant creará y gestionará la máquina virtual de forma automática:
1. Descarga el instalador oficial de [Vagrant para Windows](https://www.vagrantup.com/downloads) (arquitectura AMD64/x86_64).
2. Ejecuta el archivo descargado y completa el asistente haciendo clic en "Next" hasta finalizar.

### Paso 4: Encender la Máquina Virtual
Para evitar ingresar tu cuenta personal de Windows (o si inicias sesión con PIN y no recuerdas tu contraseña), crearemos un usuario local auxiliar en Windows exclusivo para la compartición de archivos del laboratorio:

1. Abre tu terminal de **PowerShell** con privilegios de **Administrador** (requerido por Hyper-V).
2. Crea el usuario local `vagrantlabs` ejecutando los siguientes dos comandos:
   ```powershell
   net user vagrantlabs MiPasswordSeguro123 /add
   net localgroup Administradores vagrantlabs /add
   ```
3. Inicia la máquina virtual de estudio (AlmaLinux 9) ejecutando:
   ```powershell
   vagrant up --provider=hyperv
   ```

> [!IMPORTANT]
> **1. Selección del Switch Virtual en Hyper-V**:
> Durante el arranque, Vagrant te solicitará elegir un **Virtual Switch** (Switch Virtual). 
> * **Recomendación**: Elige el número de opción correspondiente a **`Default Switch`**.
> * **Por qué**: Este switch interno de Windows viene preconfigurado con asignación de IP automática (DHCP) y traducción de red (NAT), lo que asegura que tu máquina virtual obtenga salida a Internet para el aprovisionamiento y que Vagrant pueda comunicarse con ella vía SSH.

> [!NOTE]
> **2. Credenciales de Windows (SMB)**:
> Al montar las carpetas, Vagrant te pedirá un usuario y contraseña. Utiliza la cuenta de servicio local que acabas de crear:
> * **Username (usuario)**: `vagrantlabs`
> * **Password (contraseña)**: `MiPasswordSeguro123`
> *(Nota: Vagrant no almacena tus credenciales en ningún sitio; solo las pasa localmente a Windows para autorizar el montaje de la carpeta de red hacia la VM).*


### Paso 5: Acceder a la VM y Ejecutar el Lab
1. Conéctate a la consola de la máquina virtual vía SSH:
   ```powershell
   vagrant ssh
   ```
2. Dentro de la máquina (que es un entorno Linux puro de AlmaLinux 9), navega al directorio del laboratorio y entra en el módulo que desees practicar (por ejemplo, el módulo 01):
   ```bash
   cd /labs/01-essential-tools/
   ```
3. Ejecuta la demostración animada en español para ver los comandos en acción:
   ```bash
   ./demo.sh
   ```
4. Lee las instrucciones del reto práctico:
   ```bash
   cat instructions.md
   ```
5. Realiza los cambios necesarios en el subdirectorio `challenge/` para resolver el reto (puedes ver pistas progresivas con `cat hints.md`).
6. Valida si tu solución es correcta ejecutando el validador automático no destructivo:
   ```bash
   ./verify.sh
   ```
7. Si deseas volver a practicar desde cero, limpia el entorno ejecutando:
   ```bash
   ./reset.sh
   ```

> [!TIP]
> **Sincronización de Archivos**:
> Si realizas cambios en las instrucciones o scripts de la carpeta `./labs/` en el host (Windows) con tu editor de código (como VS Code), puedes sincronizarlos con la máquina virtual en cualquier momento ejecutando desde PowerShell en Windows:
> ```powershell
> vagrant provision
> ```

---

## 🔧 Resolución de Problemas Comunes (FAQ)

### 1. ¿Por qué obtengo un error `command not found` al ejecutar herramientas como `semanage` o `autofs`?
Asegúrate de que el aprovisionamiento inicial de Vagrant se haya ejecutado por completo. Si iniciaste la máquina sin conexión a Internet o se omitió el paso, puedes forzar la instalación de los paquetes requeridos ejecutando desde PowerShell en Windows:
```powershell
vagrant provision
```
O bien de forma manual dentro de la VM (`vagrant ssh`):
```bash
sudo dnf install -y policycoreutils-python-utils autofs nfs-utils
```

### 2. ¿Cómo soluciono errores de montaje SMB/credenciales al hacer `vagrant up`?
Si Vagrant te solicita credenciales de Windows y falla la conexión de red compartida:
1. Asegúrate de haber creado el usuario local `vagrantlabs` como Administrador tal como se indica en el **Paso 4**.
2. Verifica que las políticas de red local de tu máquina no estén bloqueando el tráfico SMB (puerto `445`).

### 3. Ejecuto los evaluadores (`verify.sh`) en mi terminal local de Windows o WSL y fallan todas las pruebas
Los validadores de este laboratorio están diseñados para auditar configuraciones a nivel de kernel y servicios de Red Hat Enterprise Linux 9 (`AlmaLinux 9`). **Debes ejecutar todos los comandos del reto y evaluadores dentro de la máquina virtual** habiendo accedido previamente a través de:
```powershell
vagrant ssh
```

### 4. ¿Cómo identifico si el disco secundario de LVM está disponible?
Para los laboratorios de almacenamiento (Módulo 07 y 08), el entorno Vagrant aprovisiona un disco virtual de 5GB conectado a `/dev/sdb`. Puedes confirmar su existencia ejecutando:
```bash
lsblk
```
Si por alguna razón no aparece listado el disco `sdb`, puedes recargar la VM apagándola e iniciándola nuevamente con:
```powershell
vagrant reload
```
