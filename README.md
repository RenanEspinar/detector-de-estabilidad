# detector-de-estabilidad
Herramienta didáctica en MATLAB para visualizar polos y clasificar la estabilidad de sistemas dinámicos de forma intuitiva.
# detector-de-estabilidad

Herramienta didáctica en MATLAB para visualizar polos y clasificar la estabilidad de sistemas dinámicos de forma intuitiva.

---

## ¿Qué hace?

Este script permite:

- Obtener los polos de un sistema dinámico
- Visualizarlos en el plano complejo
- Clasificar automáticamente el sistema como:
  - Estable
  - Marginalmente estable
  - Inestable
- Mostrar una interpretación clara para estudiantes

---

## Idea clave

> "Los polos determinan la estabilidad del sistema"

- Re(s) < 0 → Sistema estable  
- Re(s) = 0 → Marginalmente estable  
- Re(s) > 0 → Sistema inestable  

---

## Uso

1. Abre MATLAB  
2. Ejecuta el script  
3. Define tu función de transferencia en la sección:

```matlab
s = tf('s');
G = ...
Estable 
G = 1/((s+1)*(s+2)*(s+3));
Margianlmente estable
G = 1/(s^2 + 1);
Inestable 
G = 1/(s-1);
