# Flashzilla
Flashzilla es una app desarrollada en SwiftUI que simula un juego de repaso utilizando tarjetas. Permite a los usuarios agregar sus propias preguntas y respuestas, repasar las tarjetas, marcar respuestas correctas o incorrectas, y reiniciar el juego. Además, incluye funcionalidades de accesibilidad y almacenamiento local de datos.
# Características
- Añadir tarjetas: Puedes crear nuevas tarjetas introduciendo el texto de la pregunta y la respuesta.
- Eliminar tarjetas: Eliminar tarjetas: Las tarjetas se pueden eliminar deslizando hacia la izquierda o derecha, o utilizando un botón para marcarla como incorrecta. Utilizo **@Environment** para integrar accesibilidad con VoiceOver, asegurando que los usuarios con discapacidades puedan interactuar con la app de manera fácil.
- Reiniciar juego: Si todas las tarjetas han sido completadas, hay un botón para reiniciar el juego, con un tiempo límite predeterminado utilizando la clase **Timer**.


![Simulator Screen Recording - iPhone 16 Pro - 2025-07-16 at 13 44 59](https://github.com/user-attachments/assets/5d23e8ae-a43b-4cc0-803c-a91895867e07)
