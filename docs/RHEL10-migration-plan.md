# Plan de Migración a RHEL 10 / AlmaLinux 10

**Fecha**: 2026-07-01  
**Estado**: Migración de strings y referencias v9 completada vía automation (2026-07-01). Vagrant + Lab 10 + limpieza general listos. Ver `docs/RHEL10-decisions.md`.  
**Objetivo**: Actualizar completamente `ex200-flow-labs` para que sea compatible y valioso para la preparación del examen **RHCSA EX200 basado en RHEL 10**.

---

## 1. Resumen Ejecutivo

El examen oficial EX200 ya está basado en **RHEL 10**. Mantener el repositorio en RHEL 9 reduce significativamente su valor educativo real.

**Problemas clave identificados**:
- Lab 09 (Podman) probablemente ya no forma parte de los objetivos oficiales (contenedores fueron removidos del EX200).
- `dnf5` es el gestor de paquetes por defecto.
- Cambios en networking, kernel, seguridad, boot y herramientas.
- Las cajas de Vagrant para AlmaLinux 10 ya existen y son funcionales.

**Decisión**: Proceder con la migración completa.

---

## 2. Estado Actual vs Estado Objetivo

| Aspecto                    | Actual (RHEL 9)              | Objetivo (RHEL 10)                  |
|---------------------------|------------------------------|-------------------------------------|
| Box de Vagrant            | `almalinux/9`                | `almalinux/10`                      |
| Gestor de paquetes        | dnf (clásico)                | dnf5 (por defecto)                  |
| Contenedores (Lab 09)     | Podman (rootless + systemd)  | **Decidir** (probablemente remover o reemplazar por Flatpak) |
| Objetivos cubiertos       | ~83% EX200 RHEL 9            | 90%+ EX200 RHEL 10                  |
| Kernel                    | 5.14                         | 6.12                                |
| Formato de red            | ifcfg (parcial)              | keyfile (predeterminado)            |
| Verificadores             | Basados en salidas RHEL 9    | Actualizados a comportamientos RHEL 10 |

---

## 3. Riesgos y Decisiones Críticas (Deben tomarse primero)

### Decisión #1: ¿Qué hacer con el Lab 09 (Podman)?
- **Opción A (Recomendada)**: Eliminar el lab de contenedores del catálogo principal.
- **Opción B**: Reemplazarlo por un nuevo lab de **Flatpak** + gestión moderna de software.
- **Opción C**: Mantenerlo como material "avanzado / legacy" (no contar en cobertura EX200).

**Impacto**: Este es el cambio de mayor alcance.

### Decisión #2: Alcance de la migración
- ¿Migrar los 15 labs o priorizar los que siguen siendo relevantes?
- ¿Mantener compatibilidad con RHEL 9 por un tiempo? (No recomendado)

### Decisión #3: Nivel de fidelidad
- ¿Usar AlmaLinux 10 como sustituto 1:1 de RHEL 10? (Sí, es la estrategia actual del proyecto).

---

## 4. Plan por Fases

### Fase 0: Investigación y Decisiones (1-2 días) ✅ COMPLETADA
- [x] Descargar y analizar los **objetivos oficiales EX200 para RHEL 10**.
- [x] Confirmar cambios (contenedores eliminados, Flatpak agregado, dnf5 default).
- [x] Tomar Decisiones #1, #2 y #3 (ver `docs/RHEL10-decisions.md`).
- [x] Actualizar `docs/objective-matrix.md`.
- [x] Branch `feature/rhel10-migration` creado.
- [x] Documento de decisiones generado.

**Entregable**: Completado. Ver `docs/RHEL10-decisions.md`.

### Fase 1: Infraestructura Base (2-3 días) - EN PROGRESO
- [x] Actualizar `Vagrantfile`:
  - Cambiado a `config.vm.box = "almalinux/10"`
  - Secondary disk de 5GB mantenido (necesario para Labs 07/08).
  - Synced folders config intacto (SMB para Hyper-V, 9p para libvirt).
- [x] Actualizar comentarios y notas para RHEL 10.
- [x] Actualizar el script de aprovisionamiento (comentarios + dnf note para dnf5).
- [x] Actualizar `docs/progress.json` con sección rhel10_migration.
- [ ] Validación completa de `vagrant up` (pendiente en entornos reales; vagrant validate syntax OK en Linux).
- [ ] Probar en los 3 proveedores.

**Criterio de salida parcial cumplido**: Vagrantfile listo para AlmaLinux 10.

**Notas de validación (2026-07-01)**:
- Usuario real en Windows + Hyper-V ejecutó exitosamente `vagrant up --provider=hyperv` con `almalinux/10`.
- Box descargada correctamente (v10.2.20260526).
- Disco secundario creado y adjuntado.
- Seleccionó Default Switch.
- SMB montado con usuario `vagrantlabs`.
- Provisioning corrió correctamente (incluyendo nota de RHEL 10).
- `vagrant ssh` funciona.
- **Fase 1 validada en hardware real (Hyper-V)**.

### Fase 2: Labs de Alto Impacto (Semana 1) - EN PROGRESO
Priorizar labs que cambian más:

| Lab | Cambios Esperados Principales | Estado |
|-----|-------------------------------|--------|
| **10** Package Management | dnf5 + Flatpak | En progreso |
| **09** Podman | Remover (decidido en Fase 0) | Pendiente |
| **03** Operating Systems | Cambios en boot, GRUB, systemd | Pendiente |
| **05** Networking | Formato keyfile, nmcli | Pendiente |
| **06** Security & SELinux | Políticas, booleanos | Pendiente |
| **13** Kernel/sysctl | Kernel 6.12 | Pendiente |

- [x] Remover Lab 09 del catálogo en README (14 laboratorios ahora).
- [x] **Lab 10 completamente actualizado**:
  - instructions.md, hints.md, verify.sh, reset.sh y demo.sh reescritos para RHEL 10.
  - Incluye DNF5 + sección completa de Flatpak + módulos + repo local.
  - Verificador ahora chequea flatpak, módulos y repo local con metadatos.

- [x] Step 3 ejecutado: Lab 09 completamente removido (labs/09-podman-containers, skeletons entries).
- [x] Step 4: docs/RHEL10-migration-plan.md actualizado con progreso y ejecución de pasos.
- Todos los 4 pasos recomendados lanzados en orden numérico.
- Migración de limpieza de referencias v9 completada.
- Siguiente acciones: git commit del estado actual.

### Fase 3: Labs Restantes (Semana 2)
Labs menos afectados pero que igual requieren revisión:
- 01 Essential Tools
- 02 Shell Scripting
- 04 Users & Groups
- 07 Local Storage (LVM + VDO)
- 08 Filesystems & Network Storage
- 11 Logging
- 12 SSH & Sudoers
- 14 Systemd Timers
- 15 Troubleshooting

- [ ] Revisión completa + ajustes menores.
- [x] Limpieza masiva de "RHEL 9 / AlmaLinux 9" completada vía automation script + targeted edits (all lab intros + README + ROADMAP).

### Fase 4: Verificación y Calidad (2-3 días)
- [ ] Ejecutar todos los `verify.sh` en una instancia limpia de AlmaLinux 10.
- [ ] Probar `reset.sh` en todos los labs.
- [ ] Probar flujo completo (demo → instructions → challenge → verify) de al menos 5 labs representativos.
- [ ] Actualizar `docs/objective-matrix.md` con cobertura real de RHEL 10.
- [ ] Actualizar `README.md`:
  - Badges
  - Quickstart
  - Recursos Adicionales
  - Menciones a versión

### Fase 5: Pruebas Multi-Proveedor y Pulido (2 días)
- [ ] Probar end-to-end en:
  - Hyper-V
  - VirtualBox
  - libvirt
- [ ] Verificar rendimiento de dnf5 (puede ser más rápido).
- [ ] Actualizar `lib/demo-common.sh` si hay comportamientos nuevos.
- [ ] Revisar Educational Quality Rules (AGENTS.md) y post-task checklist.

### Fase 6: Documentación y Lanzamiento
- [ ] Actualizar `README.md` (incluyendo tabla de laboratorios y flujo).
- [ ] Actualizar `docs/ROADMAP.md` y `docs/progress.json`.
- [ ] Escribir notas de migración / changelog.
- [ ] Considerar tag de versión (`v2.0-rhel10` o similar).
- [ ] Publicar y comunicar cambios.

---

## 5. Cambios Técnicos Esperados Más Relevantes

- **Gestor de paquetes**: Reemplazar la mayoría de usos de `dnf` por comportamiento dnf5. Revisar `dnf module` (puede haber cambiado).
- **Networking**: Migrar ejemplos de `ifcfg` a formato keyfile (`nmcli connection`).
- **Contenedores**: Decisión estratégica obligatoria.
- **Boot recovery (rd.break)**: Probar que el procedimiento siga siendo válido.
- **VDO y LVM**: Verificar que las herramientas y opciones sigan disponibles.
- **Verificadores**: Hacerlos más tolerantes a diferencias menores de salida entre versiones.

---

## 6. Estrategia de Testing

- Usar `vagrant destroy -f && vagrant up` frecuentemente.
- Mantener una rama `rhel10` + ramas por lab cuando sea posible.
- Para cada lab modificado: 
  1. Reset limpio
  2. Seguir instructions.md
  3. Verificar con `./verify.sh`
  4. Probar `./verify.sh --explain` (si existe)

---

## 7. Criterios de Éxito

- Todos los laboratorios se pueden completar exitosamente en AlmaLinux 10.
- Al menos 85-90% de cobertura de los objetivos oficiales EX200 RHEL 10.
- Los verificadores son confiables y no falsos positivos/negativos por cambios de versión.
- El flujo "vagrant up → vagrant ssh → cd /labs/XX → ./verify.sh" funciona en los tres proveedores principales.
- README y documentación reflejan claramente que está orientado a RHEL 10.

---

## 8. Esfuerzo Estimado Total

- **Optimista**: 3-4 semanas (si se decide remover el Lab 09).
- **Realista**: 5-6 semanas (incluyendo pruebas y pulido).
- **Conservador**: 7+ semanas (si se decide crear nuevo lab de Flatpak + ajustes profundos).

---

## 9. Próximos Pasos Inmediatos

1. Leer los objetivos oficiales EX200 RHEL 10 más recientes.
2. Tomar la decisión sobre el Lab 09 (reunión corta o issue).
3. Crear rama `feature/rhel10-migration`.
4. Actualizar `Vagrantfile` a `almalinux/10` y validar infraestructura (Fase 1).
5. Actualizar la matriz de objetivos.

---

**Mantener siempre las Reglas de Calidad Educativa** (ver AGENTS.md):
- Reto real y verificable.
- Verificadores confiables.
- El estudiante debe poder completar con `instructions.md` + `hints.md`.

Este plan debe actualizarse conforme se descubran nuevos detalles durante la migración.