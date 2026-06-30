# Auditoría de Calidad Educativa

**Fecha**: 2026-06-30
**Alcance**: Auditoría inicial de los laboratorios existentes contra las 7 Reglas de Calidad Educativa (ver AGENTS.md).
**Proceso**: Revisión estilo post-tarea. Enfoque en módulos críticos primero (01, 03, 07, 08 según análisis de alineación). Otros módulos al final.

## Referencia de Reglas (resumen)
1. Mapeo a objetivos oficiales
2. Reto real y verificable (simulación mínima)
3. Verificadores confiables
4. Persistencia real
5. Demo como apoyo (no muleta)
6. Reset limpio y repeatable
7. Trucos de producción no deben degradar la experiencia por defecto

## Módulo 01 - essential-tools

**Estado**: Cumplimiento parcial. Problemas con el orden y tensión entre video y educación.

- Regla 1: Bueno. Coincide con instructions (enlaces, permisos 640, grep ^EX200:).
- Regla 2: Bueno en el demo (comandos reales para redirecciones, grep, tar, enlaces, chmod).
- Regla 3: Fuerte. verify.sh usa stat, readlink, chequeo de inodo -ef, diff en la salida. Confiable.
- Regla 4: N/A (sin configuración persistente en este lab).
- Regla 5: Bueno. El reto en instructions.md es autocontenido. El demo complementa.
- Regla 6: Simple y limpio (rm -f archivos específicos).
- Regla 7: Problema. El orden de secciones en el demo (tar antes de enlaces) no coincide con la estructura de las letras. Sueños largos (5s). Potencial de simulación en cambios futuros.

**Riesgos anotados**: La alineación con letras requiere reordenar el demo o actualizar las letras. El ritmo afecta el video pero no la educación aún.

**Recomendación**: Reordenar secciones 3/4 en el demo para coincidir con las letras para sincronización. Agregar flag --video (Fase 0).

## Módulo 03 - operating-systems

**Estado**: Brecha significativa. El demo no cubre un elemento clave del reto.

- Regla 1: Parcial. El demo cubre systemctl, targets, procesos, journalctl. El reto requiere + documentación de recuperación de root con rd.break etc.
- Regla 2: Débil. Múltiples "Simulamos" + echo para comandos críticos (set-default, renice, pasos de GRUB ausentes completamente).
- Regla 3: Parcial. verify.sh chequea servicio, target y palabras clave en root_recovery.txt. Pero la secuencia GRUB no se demuestra.
- Regla 4: Los targets son persistentes en uso real; el demo simula.
- Regla 5: Problemático. El estudiante debe documentar la recuperación de root (reto de la regla 5). El demo no tiene sección al respecto. Depende solo de instructions para esta parte.
- Regla 6: Adecuado.
- Regla 7: Alto riesgo. El demo evita la recuperación real de GRUB (valor central para video y educación) por destructividad. Se agregó journalctl que es útil pero no es el foco principal del reto.

**Riesgos anotados**: La falta de demo de GRUB significa que los estudiantes pueden tener dificultades con la parte más importante. Viola comandos reales (regla 2) y demo como apoyo únicamente.

**Recomendación**: Agregar sección controlada de recuperación GRUB o simulación segura en el demo. Actualizar verify para requerir documentación más precisa. Alta prioridad para alineación y calidad.

## Módulo 07 - local-storage

**Estado**: Simulación pesada. Alta tensión con necesidades de video.

- Regla 1: Bueno. Cubre PV/VG/LV, xfs, extend -r, VDO --type vdo.
- Regla 2: Pobre. 90%+ simulación con echo "example". No hay pvcreate/vgcreate real en /dev/sdb en el demo (destructivo).
- Regla 3: Bueno en verify (vgs/lvs, mountpoint, chequeos de tamaño, lv_layout para vdo).
- Regla 4: Instructions requiere fstab + supervivencia a reboot. El demo solo muestra ejemplos.
- Regla 5: Débil para las partes de LVM. El estudiante necesita comandos reales de instructions; el demo es casi pura ilustración.
- Regla 6: Bueno (umount, lvremove, vgremove, pvremove, sed fstab).
- Regla 7: Conflicto. La ejecución real completa sería ideal para educación pero riesgosa para grabaciones repetidas de video. El demo actual prioriza seguridad sobre demostración.

**Riesgos anotados**: Los estudiantes obtienen menos "verlo correr" para un tema complejo. El verify es fuerte pero el demo no construye memoria muscular.

**Recomendación**: Explorar alternativas seguras (dispositivos loop, disco de prueba dedicado en Vagrant, o documentado "ejecutar en VM reseteada"). Balancear con modo --video que pueda saltar ejecución real.

## Módulo 08 - filesystems-network

**Estado**: Moderado. Buenos conceptos, algo de simulación.

- Regla 1: Bueno (UUID en fstab, mapas autofs, NFS).
- Regla 2: Mixto. Ejemplos blkid y mount reales; muchas "Simulamos" para mkfs, ediciones fstab, configuración autofs.
- Regla 3: Fuerte en verify (grep fstab para UUID, mountpoint, systemctl autofs, contenido de mapa, prueba de montaje forzado).
- Regla 4: Núcleo del lab (fstab con UUID + persistencia autofs).
- Regla 5: Razonable.
- Regla 6: Bueno.
- Regla 7: El demo dedica tiempo a NFS/SMB manual que las letras des-enfatizan. Problema de ritmo/sueños universal.

**Riesgos**: Posible desajuste menor de orden vs letras.

## Otros Módulos (revisión rápida)

- 02,04,05,06,09: Generalmente mejor cumplimiento (menos simulaciones en demos, buena cobertura de verificadores, mapeo fuerte de reglas).
- Común en todos: sleep 5.0 en run_demo_cmd viola video eficiente (regla 7 indirectamente) y hace lenta la experiencia por defecto.
- Los resets generalmente buenos.
- Los verificadores mayormente confiables pero algunos text-greps pueden ser frágiles (mejora futura).

## Resumen y Acciones

**Áreas de violaciones / débiles**:
- Regla 2 y 7 más impactadas en 01,03,07,08 por simulación y ritmo.
- Regla 5 en módulo 03 (el demo omite elemento mayor del reto).
- Regla 4 parcialmente débil donde domina la simulación.

**Progreso reciente**:
- Todos los 9 módulos usan `lib/demo-common.sh` para soporte consistente de `--video` / `--fast`.
- Módulo 01: Secciones reordenadas (links antes de tar) para mejor alineación con las letras.
- Módulo 07: Simulación reducida significativamente (comandos LVM reales + limpieza).
- Módulo 03: Agregada sección GRUB recovery.
- Mejoras en alineación y calidad para producción de video y educación.

**Siguientes**:
- Aplicar checklist a todo trabajo futuro.
- Reducir simulación en módulo 07 con alternativas seguras.
- Re-auditar después de cambios de Fase 0.

**Puntuación de cumplimiento (aprox., con cambios)**: 01: 6.5/7, 03: 5/7, 07: 4.5/7, 08: 5.5/7. Otros ~6.5/7.

Archivo generado como parte de evaluación C. Actualizar después de cambios.

## Revisión Post-Tarea: Herramientas de Video + Gobernanza (Jun 2026)

**Cambios auditados**:
- `lib/demo-common.sh` (nueva biblioteca compartida)
- Refactor de los 9 `demo.sh` para usar la lib + flags `--video` / `--fast`
- `scripts/generate-video-skeleton.sh` (mejora estructural del generador)
- Actualización mayor de `AGENTS.md` (incorporación de ANTI-LOOP RULE + checklist existente)

### Evaluación contra las 7 Reglas

| # | Rule | Status | Notas |
|---|------|--------|-------|
| 1 | Mapeo a objetivos | ✅ Bueno | Los cambios no alteran los objetivos EX200 cubiertos. Mejoran la capacidad de demostrarlos en video. |
| 2 | Reto real | ✅ Bueno | `run_demo_cmd` ejecuta comandos reales vía `eval`. Módulo 07 mejorado con LVM real. Algunas simulaciones intencionales (gdisk/fdisk interactivos) se mantienen justificadas. |
| 3 | Verificadores confiables | ➖ Sin cambio | Esta iteración no tocó los `verify.sh`. Pendiente para Fase 0. |
| 4 | Persistencia | ➖ N/A | No aplica a este trabajo de infraestructura de demos. |
| 5 | Demo como apoyo | ✅ Excelente | Comportamiento por defecto (sin flags) mantiene sleeps educativos (~5s). Los modos `--video`/`--fast` son explícitamente opt-in. El estudiante puede ignorar los flags. |
| 6 | Reset limpio | ➖ Sin cambio | No se modificaron los reset.sh en esta tanda. |
| 7 | Trucos de producción | ✅ Excelente | La implementación separa claramente el modo por defecto (educativo) del modo video. Ninguna optimización de video degrada la experiencia estándar. El generador es tooling interno. |

**Conclusión**: Los cambios cumplen bien las reglas, especialmente la #5 y #7. El diseño de la biblioteca prioriza preservar la experiencia educativa por defecto mientras habilita producción de video de alta calidad.

**Riesgo documentado**: Ninguno crítico. Se recomienda aplicar esta checklist después de cada entrega significativa.