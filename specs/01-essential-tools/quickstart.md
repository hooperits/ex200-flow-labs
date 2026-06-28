# Quickstart Guide: 01-essential-tools

Esta guía rápida describe cómo inicializar el entorno y comenzar a practicar con el módulo **01-essential-tools** bajo el nuevo diseño nativo.

## Paso 1: Levantar el Entorno Vagrant

Asegúrate de estar en el directorio raíz del proyecto en tu terminal o consola de Windows (PowerShell, CMD, o Git Bash) y ejecuta:

```powershell
vagrant up --provider=hyperv
```

Una vez que la máquina Rocky Linux 9 esté encendida, accede a ella mediante SSH:

```powershell
vagrant ssh
```

## Paso 2: Ir al Directorio del Laboratorio

Dentro de la VM Rocky Linux 9, navega al directorio del laboratorio del módulo 01:

```bash
cd /labs/01-essential-tools/
```

## Paso 3: Ver la Demostración Interactiva

Antes de intentar resolver el reto, ejecuta el script de demostración guiada para comprender los conceptos en acción:

```bash
./demo.sh
```

El script mostrará ejemplos interactivos sobre redirecciones, enlaces, compresión, filtros `grep` y permisos.

## Paso 4: Resolver el Reto

1. Lee las instrucciones del challenge en:
   ```bash
   cat instructions.md
   ```
2. Realiza los cambios necesarios en el subdirectorio `challenge/` (crear enlaces, modificar permisos, comprimir archivos, filtrar datos con `grep`, etc.).
3. Si te encuentras atascado, puedes revisar las pistas progresivas:
   ```bash
   cat hints.md
   ```

## Paso 5: Evaluar y Validar

Ejecuta el script evaluador automatizado no destructivo para verificar si completaste correctamente el reto:

```bash
./verify.sh
```

Si todos los objetivos muestran `PASSED` y el script retorna código 0, ¡has completado el laboratorio!

## Paso 6: Reiniciar el Entorno (Opcional)

Si deseas volver a practicar el reto desde cero, restablece el entorno ejecutando:

```bash
./reset.sh
```
