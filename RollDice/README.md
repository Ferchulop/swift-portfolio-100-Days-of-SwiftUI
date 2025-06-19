# RollDice

Roll Dice es una app desarrollada en SwiftUI, utilizando **SwiftData** para la persistencia de los datos y **CoreHaptics** para la retroalimentación táctil durante el lanzamiento.
Es minimalista y animada para lanzar dados, puedes ver y consultar los resultados, está basada en todo lo aprendido en mis proyectos anteriores. Supone el último challenge independiente,
del día 95 del reto **100 Days of SwiftUI**.


## Características

- Lanza de 1 a 5 dados con animación 3D (`.rotation3DEffect`)
- Guarda automáticamente cada tirada con:
  - Fecha y hora
  - Número de dados
  - Total obtenido
- Visualiza el historial de tiradas en una lista ordenada.
- Elimina resultados fácilmente.
- Tiene efectos hápticos personalizados con `CoreHaptics` en cada tirada de dados.
  
![Simulator Screen Recording - iPhone 16 Pro - 2025-06-19 at 19 44 16](https://github.com/user-attachments/assets/3dddba7c-91d7-4391-96c6-8b61a0fc0ec3)
