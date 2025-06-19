# Treasure Moment
TreasureMoment es una app desarrollada en SwiftUI que permite a los usuarios importar fotos y almacenarlas junto con su ubicación geográfica. Los usuarios pueden ver las fotos en un mapa, y cada foto se asocia con las coordenadas de la ubicación en la que fue hecha. Rastrea la ubicación en tiempo real, guarda la foto con nombre, visualiza el detalle. Basada en todo lo aprendido en mis proyectos anteriores. 
## Características
### Retos como:

### 1. **Correcta visualización de la imagen en la lista:**
Un challenge fue garantizar que las imágenes seleccionadas se mostraran correctamente, tanto en la lista de fotos como en el mapa. La dificultad estaba en que, al trabajar con imágenes almacenadas como Data, tuve que asegurarme de que las imágenes se deserializaran y se presentaran adecuadamente en la vista. Además, era importante manejar correctamente el redibujado de la vista cuando se seleccionaba una nueva imagen.

### 2. **Ubicación de los botones "Start Tracking Location" y "Read Location":**
La organización para no romper el orden de la interfaz fue otro challenge a destacar. Incluir los botones de manera que fueran accesibles y estéticamente agradables fue un challenge. Los botones necesitaban estar en una ubicación intuitiva, pero también debía asegurarme de que no interfieran con otras funcionalidades de la app, como la visualización del mapa.

### 3. **Visualizar la última localización disponible al importar la imagen:**
El mayor challenge de todos fue asociar la ubicación geográfica con cada foto de manera correcta. Cuando se importaba una imagen, necesitaba asociar las coordenadas de la última localización disponible del iPhone a la foto, pero sólo si ya estaba disponible. Si la localización no estaba en ese momento, la app debía manejar la visualización de una ubicación predeterminada y, una vez que la localización real estuviera disponible, actualizarla automáticamente.

![Simulator Screen Recording - iPhone 16 Pro - 2025-01-31 at 14 15 06 (1)](https://github.com/user-attachments/assets/471dabdc-0bec-4db2-ad0c-83ac25236185)
