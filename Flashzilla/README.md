# Flashzilla
Flashzilla es una app desarrollada en SwiftUI que simula un juego de repaso utilizando tarjetas. Permite a los usuarios agregar sus propias preguntas y respuestas, repasar las tarjetas, marcar respuestas correctas o incorrectas, y reiniciar el juego. Además, incluye funcionalidades de accesibilidad y almacenamiento local de datos.
# Características
- Añadir tarjetas: Puedes crear nuevas tarjetas introduciendo el texto de la pregunta y la respuesta.
- Eliminar tarjetas: Eliminar tarjetas: Las tarjetas se pueden eliminar deslizando hacia la izquierda o derecha, o utilizando un botón para marcarla como incorrecta. Utilizo **@Environment** para integrar accesibilidad con VoiceOver, asegurando que los usuarios con discapacidades puedan interactuar con la app de manera fácil.
- Reiniciar juego: Si todas las tarjetas han sido completadas, hay un botón para reiniciar el juego, con un tiempo límite predeterminado utilizando la clase **Timer**.


![Simulator Screen Recording - iPhone 16 Pro - 2025-04-03 at 20 19 09](https://github.com/user-attachments/assets/c655eecf-2cb4-435d-9aa5-20906538c9e0)
