# Reto Práctico: Seguridad del Sistema, Cortafuegos y SELinux (Módulo 06)

Este reto evalúa tu capacidad para gestionar la seguridad del sistema en AlmaLinux 10 / RHEL 10 mediante la configuración de políticas en el cortafuegos `firewalld` y el ajuste fino de contextos y booleanos en `SELinux`.

**Nota RHEL 10**: firewalld y semanage son muy similares. Algunas políticas de SELinux son más estrictas por defecto.

## Objetivos del Reto

Realiza las siguientes configuraciones de seguridad en el sistema:

1. **Configurar el Cortafuegos (`firewalld`)**:
   * Agrega de forma permanente el servicio **`http`** en la zona predeterminada (`public`).
   * Agrega de forma permanente el puerto **`82/tcp`** en la zona predeterminada (`public`).
   * Aplica los cambios en caliente (recarga el firewall) para activar las reglas inmediatamente.

2. **Crear y Corregir Contextos de SELinux**:
   * Crea el directorio `/var/www/custom_html` (debes crearlo tú mismo).
   * Define una regla de contexto en SELinux de modo que `/var/www/custom_html` y todo su contenido (incluidos futuros archivos) utilicen el contexto estándar de servicio web: **`httpd_sys_content_t`**.
   * Aplica y restaura el contexto de seguridad sobre el directorio recién creado para que se aplique físicamente el cambio.

3. **Modificar Booleanos de SELinux**:
   * Habilita de forma persistente (que sobreviva a reinicios del sistema) el booleano de SELinux **`httpd_enable_homedirs`** configurándolo en **`on`** (activo).

## Evaluación

Una vez que configures las reglas y políticas, valida tu solución ejecutando:

```bash
./verify.sh
```

Puedes ver pistas progresivas en `hints.md` y restablecer el entorno a su estado original con `./reset.sh`.

