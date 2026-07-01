# Plan: Rediseño del README.md - Enfoque en Despliegue + Catálogo de Laboratorios

**Fecha**: 2026-07-01
**Objetivo**: Reescribir completamente el README.md aplicando mejores prácticas de GitHub, con **énfasis principal en las instrucciones claras de cómo desplegar el entorno de laboratorios**, y presentar una tabla profesional y completa de los **15 laboratorios** con accesos directos a las instrucciones de cada reto.

**Contexto**:
- El README actual (200 líneas) está desactualizado: solo documenta laboratorios 01-09.
- El Vagrantfile soporta 3 proveedores (Hyper-V, VirtualBox, libvirt), pero los docs solo hablan de Hyper-V + Windows.
- Existe una fuerte necesidad de separar "Cómo desplegar el lab" del "Cómo usar los retos".
- Debe respetar las Reglas de Calidad Educativa (AGENTS.md): narrativa 100% en español, comandos técnicos en inglés, sin menciones de producción de video/YouTube/Suno.
- El estudiante debe poder empezar usando solo `instructions.md` + `hints.md`.

---

## 1. Principios del Nuevo README

1. **Deploy-First**: Las instrucciones de despliegue (setup) son el contenido principal y más visible.
2. **Accesibilidad Inmediata a Labs**: Una tabla excelente permite saltar directamente a cualquier reto.
3. **Multi-Plataforma Clara**: Soporte explícito y recomendado de los 3 proveedores desde el principio.
4. **GitHub Best Practices**:
   - Badges útiles y actualizados.
   - Quickstart corto y accionable (TL;DR).
   - Uso de secciones plegables (`<details>`) para detalles avanzados.
   - Tablas bien estructuradas con enlaces primarios claros.
   - Mermaid o diagramas donde ayuden.
   - Call-to-action fuerte (Star, contribuir, pasar el examen).
5. **Concisión + Profundidad**: Quickstart de 5 minutos + guías detalladas por proveedor en secciones colapsables.
6. **Consistencia con el proyecto**:
   - Idioma: Español (narrativa pública).
   - Enlaces relativos a `labs/XX/...`.
   - Mencionar `verify.sh`, `reset.sh`, `hints.md`, `demo.sh` como apoyo.
   - Referenciar `docs/objective-matrix.md` para cobertura oficial.
7. **Sin degradación educativa**: El README debe reforzar que el reto real se resuelve con `instructions.md`.

---

## 2. Estructura Propuesta del Nuevo README (Orden Recomendado)

```
1. Header Visual (ASCII o mejorado + Badges actualizados)
   - Badges: RHCSA EX200, RHEL9/AlmaLinux9, Vagrant (multi), Español, 15 Labs

2. Descripción Corta + Valor (1-2 párrafos + cita)

3. 🚀 Quickstart en 5 Minutos (TL;DR accionable)
   - Pasos numerados mínimos para llegar a `vagrant ssh`
   - Nota de "elige tu proveedor"

4. 📋 Requisitos Previos (Checklist por SO)

5. 🖥️ Proveedores Soportados (Tabla clara + Recomendaciones)
   | Proveedor     | SO Host recomendado | Notas importantes                  | Comando sugerido          |
   |---------------|---------------------|------------------------------------|---------------------------|
   | Hyper-V       | Windows 10/11 Pro   | Requiere usuario local admin       | --provider=hyperv         |
   | VirtualBox    | macOS / Windows / Linux | Más universal                     | --provider=virtualbox     |
   | libvirt/KVM   | Linux               | Requiere plugin + privilegios      | --provider=libvirt        |

6. 🔧 Guía Detallada de Despliegue
   - 6.1 Windows + Hyper-V (detallado, incluye creación de usuario vagrantlabs)
   - 6.2 macOS + VirtualBox
   - 6.3 Linux + VirtualBox o libvirt (colapsable)
   - Pasos comunes después de `vagrant up`

7. ✅ Verifica tu Despliegue (Comandos de humo)
   ```bash
   vagrant ssh
   ls /labs
   lsblk          # para storage labs
   ./verify.sh --help o similar (dentro del lab)
   ```

8. 📚 Catálogo de Laboratorios (LA TABLA ESTRELLA)
   - 15 filas completas.
   - Columnas recomendadas:
     | # | Laboratorio | Descripción Corta | Instrucciones (Principal) | Demo | Validar | Reset | Pistas |
   - Enlaces directos a `labs/XX/instructions.md` como acción principal.
   - Usar formato amigable: "01 - Herramientas Esenciales"
   - Opcional: Agrupar por temas EX200 (Herramientas, Sistema, Usuarios, Red/Seguridad, Almacenamiento, Contenedores, etc.)

9. 🔄 El Flujo Recomendado de Estudio
   - Mermaid corto (1→Entender demo → 2→Reto instructions → 3→Verificar → Pistas/Reset)
   - Enfatizar: "instructions.md + hints.md son suficientes para completar el reto"

10. 🛠️ Uso Diario Dentro de la VM
    - `cd /labs/XX-lab/`
    - Comandos clave
    - `vagrant provision` para sincronizar cambios del host

11. ❓ Resolución de Problemas (FAQ orientado a deploy)
    - Credenciales SMB / montaje
    - Disco sdb no aparece
    - Provider choice
    - `command not found` → provision
    - Ejecutar verify fuera de la VM (error común)
    - vagrant reload vs destroy/up

12. 📖 Recursos Adicionales
    - Matriz de Objetivos Oficiales (`docs/objective-matrix.md`)
    - Cobertura ~83%
    - Enlace a EX200 oficial de Red Hat
    - CLI `bin/ex200` (nota que es stub experimental)

13. ⭐ Contribuye + Llamado a la Acción
    - Star el repo
    - Issues / PRs
    - "Si te ayudó a pasar el EX200, ¡cuéntanos!"

14. Licencia / Notas finales (si aplica; actualmente sin LICENSE explícita)
```

---

## 3. Cambios Específicos de Contenido

### Eliminar / Reducir
- Texto repetitivo de pasos que mezcla "dentro de VM".
- Referencias únicas a Hyper-V como único entorno.
- Tabla incompleta de solo 9 labs.
- Notas demasiado largas sobre creación de usuario en el flujo principal (mover a sección específica).

### Añadir / Mejorar
- Matriz clara de proveedores + advertencias por proveedor.
- Quickstart ultra-corto arriba.
- Tabla completa de 15 laboratorios con nombres exactos tomados de `instructions.md`.
- Sección "Verifica tu entorno" con comandos concretos.
- Enlaces a `docs/objective-matrix.md` y mención de alineación con objetivos oficiales.
- Notas sobre persistencia (los cambios en VM suelen sobrevivir a reinicios de VM, salvo reset.sh).
- Mejor uso de admonitions de GitHub (`> [!NOTE]`, `> [!IMPORTANT]`, `> [!TIP]`).

### Tabla de Laboratorios - Nombres Consistentes (basados en headers actuales)

01. Herramientas Esenciales del Examen EX200
02. Creación de Script en Bash (Módulo 02)
03. Operación del Sistema (Módulo 03)
04. Gestión de Usuarios y Grupos (Módulo 04)
05. Configuración de Red, NTP y Tareas Cron (Módulo 05)
06. Seguridad del Sistema, Cortafuegos y SELinux (Módulo 06)
07. Configuración de Almacenamiento Local y LVM (Módulo 07)
08. Sistemas de Archivos Locales y Montajes de Red (Módulo 08)
09. Gestión de Contenedores con Podman (Módulo 09)
10. Gestión de Paquetes y Repositorios para el Examen EX200
11. Logging y Journalctl Avanzado para el Examen EX200
12. SSH, Claves y Sudoers para el Examen EX200
13. Parámetros del Kernel y sysctl para el Examen EX200
14. Systemd Timers para el Examen EX200
15. Troubleshooting Escenarios para el Examen EX200

**Enlace primario siempre**: `[Instrucciones](labs/XX-.../instructions.md)`

Columnas secundarias:
- `[Demo](labs/.../demo.sh)` (con nota: "visual de apoyo")
- `[Validar](./verify.sh)`
- `[Reset](./reset.sh)`
- `[Pistas](./hints.md)`

---

## 4. Consideraciones Técnicas y Formato

- Mantener el espíritu del header ASCII artístico o evolucionarlo ligeramente si ayuda a la legibilidad.
- Usar badges actualizados:
  - `15 Laboratorios`
  - `Multi-Provider`
  - Mantener "Español"
- Todas las instrucciones de comandos de host deben indicar claramente el shell (PowerShell / Terminal / bash).
- Incluir nota sobre sincronización de archivos (`vagrant provision`).
- Incluir recomendación de orden: seguir los laboratorios secuencialmente 01→15.
- Enfatizar que **todo el trabajo del reto se hace dentro de la VM** después de `vagrant ssh`.

---

## 5. Pasos de Implementación

1. Leer el README actual completo + Vagrantfile + objective-matrix + estructura real de labs (hecho).
2. Escribir el nuevo `README.md` usando formato limpio y profesional.
3. Validar todos los enlaces relativos (instrucciones, verify, etc.).
4. Revisar contra las Reglas de Calidad Educativa (no degradar la experiencia de usar instructions.md).
5. Revisar que no haya fugas de estrategia de contenido (video/lyrics).
6. Probar visualmente el markdown (idealmente en GitHub preview).
7. Actualizar cualquier badge roto.
8. Opcional: Añadir un pequeño diagrama de arquitectura (host → Vagrant → VM AlmaLinux → /labs).

---

## 6. Verificación Post-Implementación (Checklist)

- [ ] Todos los 15 laboratorios aparecen en la tabla.
- [ ] Enlaces a instructions.md funcionan (relativos desde raíz).
- [ ] Quickstart permite llegar a un shell en la VM en < 8 pasos claros.
- [ ] Se menciona soporte para los 3 proveedores principales.
- [ ] FAQ de deploy está actualizado y útil.
- [ ] Narrativa en español correcto.
- [ ] No menciona YouTube, Suno, RAP, video production.
- [ ] Se recomienda `instructions.md` + `hints.md` como vía principal.
- [ ] Referencia a matriz de objetivos y cobertura.
- [ ] Formato GitHub-friendly (tablas, admonitions, mermaid si se usa).
- [ ] Longitud razonable: más estructurado y escaneable que el actual.

---

## 7. Riesgos y Mitigación

| Riesgo | Mitigación |
|--------|------------|
| Demasiada información → overwhelm | Quickstart primero + secciones colapsables para proveedores |
| Enlaces rotos al renombrar labs | Usar los nombres de carpetas reales (01-essential-tools etc.) |
| Usuario en Windows sigue instrucciones viejas | Reemplazar por guía clara + advertencia de multi-provider |
| Olvidar algún lab 10-15 | Generar la tabla a partir del listado real de `labs/` |
| Violación de políticas de idioma | Revisión final en español |

---

## 8. Entregables

- `README.md` completamente actualizado (reemplaza el actual).
- Este plan documentado en `docs/readme-update-plan.md` (para trazabilidad).
- (Opcional futuro) Capturas de pantalla de `vagrant up` por proveedor.

---

**Próximo paso inmediato**: Implementar el nuevo README siguiendo este plan (sin micro-iteraciones innecesarias). Usar read-first antes de edits grandes.

**Criterio de éxito**: Un visitante nuevo puede:
1. Clonar.
2. Elegir proveedor.
3. Ejecutar `vagrant up`.
4. Entrar y ver la lista de labs.
5. Hacer clic en cualquier "Instrucciones" y empezar a resolver retos reales.
