# Bookworm
Bookworm es una app desarrollada en SwiftUI, utilizando SwiftData. Para gestionar y almacenar libros de forma persistente. Permite a los usuarios añadir, editar y eliminar libros, así como visualizar sus detalles. Ideal para quienes desean llevar un registro de su colección de libros junto con reseñas y calificaciones.

## Características

- Gestión de libros: Añade libros con detalles como título, autor, género, reseña, calificación y fecha de inclusión. Interfaz personalizada para mostrar en rojo, alertas de borrado de libro y con emoji descriptivo dependiendo de la calidad de la  calificación.
- SwiftData: Para la persistencia de datos, dónde almaceno los libros de manera permanente, con la clase Book y uso de macro @Model(gestionar, almacenar y consultar los datos).
- Visualización de detalles y formulario para añadir libro: uso del property wrapper @Environment(gestionará las operaciones CRUD), alertas personalizadas, añadido de fecha, ScrollView para visualizar la vista, Picker(seleccion genero), .disabled(inhabilitar).
- Vistas personalizadas para calificacion: uso de @Binding(comparte y modifica el valor de calificación entre vista hija a padre), funcion para retornar imagenes segun calificacion en ContentView, uso de switch para contemplar las posibles calificaciones.
- ContentView: Uso de @Query(consulta para obtener de forma ordenada libros por titulo y autor), NavigationDestination(muestra vista de detalles), .sheet(para mostrar vista formulario de libro al añadir con boton "+"), .OnDelete(modificador para eliminar libros de la lista).
  
![Uploading Simulator Screen Recording - iPhone 16 Pro - 2025-07-16 at 14.01.08.gif…]()
