<!--
Version change: 1.0.0 → 1.1.0
List of modified principles:
- Added Principle VI: Visibilidad Pública y README de Alta Calidad.
Added sections: None
Removed sections: None
Templates requiring updates: None
Follow-up TODOs: None
-->

# ex200-flow-labs Constitution

## Core Principles

### I. Infraestructura Aislada y Reproducible (Vagrant/Hyper-V)
Todo el entorno de laboratorios y ejercicios prácticos MUST ejecutarse dentro de la máquina virtual compatible con RHEL 9 (Rocky/AlmaLinux 9) gestionada por Vagrant con el proveedor de Hyper-V. Ningún comando del laboratorio o configuración del examen se ejecutará directamente sobre el sistema host o WSL, garantizando el aislamiento completo del sistema operativo del usuario.

### II. Estructura de Módulos Estandarizada
Cada laboratorio de tema del examen MUST estar ubicado en su propio directorio y contener obligatoriamente los siguientes de forma estructurada en Bash puro o Markdown:
1. `demo.sh`: Script interactivo y visual que demuestra el concepto.
2. `instructions.md`: Requisitos detallados del reto en español.
3. `hints.md`: Pistas o ayudas progresivas para resolver el reto.
4. `verify.sh`: Script evaluador automatizado no destructivo.
5. `reset.sh`: Script que restablece el entorno del laboratorio a su estado inicial.

### III. Mnemotecnia Musical Externa (Lyrics)
Para cada laboratorio de tema, se MUST generar una letra de rap técnico en español detallando los comandos y flags clave del examen. Estos archivos se almacenarán exclusivamente de forma externa en `/home/juanca/RHCSA-EX200-lyrics` para su posterior uso en Suno y revid.ai. No se deben subir estos archivos al repositorio de Git para mantener limpio el entorno de código.

### IV. Localización Lingüística y Vocabulario Técnico
Toda la documentación, instrucciones de retos, comentarios de código y mensajes de salida de la terminal MUST estar redactados en español. Sin embargo, todos los comandos (`systemctl`, `pvcreate`), flags (`-m`, `-L`, `-G`), nombres de configuraciones, servicios y conceptos oficiales de Red Hat (como *Volume Group*, *SELinux*, *cron*) MUST permanecer en su inglés original para simular con precisión el examen de certificación.

### V. Evaluación Analítica No Destructiva
Los scripts de verificación (`verify.sh`) MUST ser puramente analíticos y no destructivos. Su función es evaluar si el sistema cumple con los requisitos del reto (ej. inspeccionar archivos, leer estados de servicios o discos) sin modificar archivos ni alterar configuraciones por sí mismos. Deben retornar códigos de salida estándar (0 para éxito, no-0 para error) y mostrar resultados limpios de PASSED/FAILED.

### VI. Visibilidad Pública y README de Alta Calidad
El repositorio principal de este proyecto es público y está alojado en GitHub bajo el nombre `ex200-flow-labs`. Para garantizar que sea atractivo y útil para otros estudiantes, la raíz del repositorio MUST contar con un `README.md` con un diseño visual premium, estructurado con badges, diagramas explicativos y una barra de progreso que refleje el avance del temario. Este `README.md` MUST ser actualizado de manera obligatoria cada vez que se complete la especificación, plan o desarrollo de un nuevo laboratorio.

## Entorno Tecnológico y Herramientas Permisibles

El desarrollo de este sistema y los laboratorios se limita estrictamente a las siguientes tecnologías:
- **Distribución de VM:** Rocky Linux 9 / AlmaLinux 9.
- **Orquestación de VM:** Vagrantfile configurado con Hyper-V Provider.
- **Lenguaje de Scripting de Laboratorios:** Bash puro.
- **Configuraciones adicionales de la VM:** Scripts de aprovisionamiento de Vagrant.

## Proceso de Creación de un Nuevo Laboratorio (Flujo de Trabajo)

La incorporación de cualquier nuevo tema o laboratorio en el repositorio se regirá bajo el flujo de desarrollo de spec-kit:
1. **Especificación (`specs/`):** Creación del archivo de especificación detallando los objetivos específicos de aprendizaje, la lógica del demo y los criterios de verificación.
2. **Plan de Implementación:** Diseño técnico del aprovisionamiento necesario en Vagrant y la lógica de verificación.
3. **Desglose de Tareas:** Creación del checklist de tareas para implementar los archivos del lab.
4. **Implementación y Verificación:** Codificación de los scripts en la carpeta del lab y prueba en la VM Vagrant.
5. **Actualización de Documentación:** Actualizar el `README.md` principal para reflejar el nuevo estado del laboratorio.

## Governance

- Esta constitución supersedes cualquier otra directriz de desarrollo en el repositorio.
- Cualquier modificación a los principios descritos en esta constitución requerirá una justificación explícita y un incremento en la versión semántica de la constitución.
- El versionamiento se regirá por SemVer:
  - MAJOR: Cambios drásticos en la arquitectura o principios de los laboratorios.
  - MINOR: Adición de nuevas tecnologías de apoyo o principios no restrictivos.
  - PATCH: Correcciones de redacción o aclaraciones menores.

**Version**: 1.1.0 | **Ratified**: 2026-06-28 | **Last Amended**: 2026-06-28
