# Fase 0: Investigación y Decisiones - Migración a RHEL 10

**Fecha de ejecución**: 2026-07-01  
**Branch**: `feature/rhel10-migration`  
**Responsable**: Fase 0

## 1. Investigación de Objetivos Oficiales EX200 (RHEL 10)

**Fuente principal**:
- Página oficial: https://www.redhat.com/en/services/training/ex200-red-hat-certified-system-administrator-rhcsa-exam
- Confirmado: "This exam is based on Red Hat® Enterprise Linux® 10."

**Objetivos principales actuales (EX200 v10)** basados en fuentes oficiales y actualizadas (2026):

1. **Understand and use essential tools**
2. **Manage software** (incluye RPM, DNF5, repositorios y **Flatpak**)
3. **Create simple shell scripts**
4. **Operate running systems** (systemd, targets, procesos, logging, tuning, boot)
5. **Manage local users and groups**
6. **Manage storage** (partitions, LVM, filesystems, fstab, etc.)
7. **Configure networking and hostname resolution**
8. **Manage security** (firewalld + SELinux)
9. **Troubleshoot** (integrado en varios)

**Cambios confirmados más importantes**:
- **Manage containers / Podman**: **Eliminado** de los objetivos del EX200.
  - Fuentes confiables (entrenadores, Reddit, análisis de objetivos) confirman que "Manage containers" ya no aparece.
  - Se movió a un examen separado (EX188 mencionado).
- **Manage software**: Ahora incluye explícitamente **Flatpak** además de RPM/DNF.
- DNF5 es el gestor de paquetes predeterminado en RHEL 10.
- Cambios menores en networking (keyfile preferido), kernel 6.12, mejoras en seguridad y Web Console.

## 2. Decisiones Tomadas en Fase 0

### Decisión #1: Lab 09 - Podman Containers
**Decisión**: **Eliminar el Lab 09 del catálogo principal de labs para EX200**.

**Razón**:
- El objetivo de contenedores fue removido del examen EX200.
- Mantenerlo distorsionaría la cobertura y daría una falsa sensación de preparación.
- El lab puede ser archivado o movido a un repositorio separado "avanzado" más adelante.

**Acción**:
- Remover Lab 09 de la tabla en README.md.
- Actualizar la matriz de objetivos (quitar cobertura de contenedores).
- Renumerar o ajustar si es necesario (mantener 14 labs por ahora o renumerar después).

### Decisión #2: Alcance de la migración
**Decisión**: Migrar **todos los labs restantes** adaptándolos a RHEL 10 + agregar soporte para Flatpak en el área de software.

**Excepciones**:
- Lab 09 → eliminado.
- Se priorizará agregar/expandir Flatpak en el Lab 10 o crear un pequeño módulo nuevo.

### Decisión #3: Base técnica
**Decisión**: Usar **AlmaLinux 10** como base (igual que antes con AlmaLinux 9).
- Cajas oficiales de Vagrant existen y soportan Hyper-V, VirtualBox y libvirt.
- AlmaLinux 10 es binariamente compatible con RHEL 10.

### Decisión #4: Cobertura objetivo
**Decisión**: Apuntar a **≥ 90%** de los objetivos oficiales EX200 RHEL 10.
- Actualizar `docs/objective-matrix.md` completamente.
- Remover referencias a "containers" como objetivo EX200.

### Decisión #5: Enfoque de cambios
- **dnf5** será el enfoque principal en Lab 10.
- Mantener el estilo educativo actual (instrucciones detalladas en español, verify.sh robustos).
- Probar persistencia real después de reboot en labs de configuración.

## 3. Entregables de Fase 0

- [x] Branch `feature/rhel10-migration` creado.
- [x] Este documento de decisiones.
- [ ] Matriz de objetivos actualizada para RHEL 10 (en progreso).
- [ ] Actualización del plan general con estas decisiones.

## 4. Próximos Pasos (Fin de Fase 0 → Fase 1)

1. Actualizar `docs/objective-matrix.md` con la nueva información de RHEL 10.
2. Iniciar Fase 1: Actualizar Vagrantfile a `almalinux/10` y validar infraestructura.
3. Actualizar README.md (menciones a versión, tabla de labs si se remueve Lab 09).

**Notas adicionales**:
- Muchos usuarios aún usan RHEL 9.6 para practicar el examen RHEL 10 porque los cambios no son radicales en la mayoría de áreas.
- Sin embargo, para que el repo "aporte valor real", debemos alinearnos con la versión oficial del examen.