# CupcakeCorner
CupcakeCorner es una app desarrollada en SwiftUI, de pedidos de cupcakes. Permite a los usuarios personalizar y realizar pedidos a través de un formulario. La app integra una funcionalidad de red asíncrona para enviar el pedido a un servidor y mostrar una confirmación de pedido tras su procesamiento. La cual tambien se necesita hacer debugging con LLDB para rastrear el flujo y enviar los datos correctamente al servidor.

## Características: 
- Lógica, clase Order: uso de @Observable, propiedades calculadas, **CodingKey**(mapeo de propiedades para que el servidor interprete correctamente las propiedades)
- Personalización de Pedido: Selecciona tipo y cantidad, uso de Stepper y Picker.
- Solicitud especial: Uso de Toogle para añadir ingrediente extra.
- Formulario para datos de cliente: Cumplimentar datos personales de cliente, uso de Form(datos personales), .disabled(para deshabilitar), @Bindable(actualizar vista automaticamente si alguna propiedad cambia)
- Cálculo de Coste en Tiempo Real: Propiedad calculada(considera cantidad, tipo y extras), solicitud HTTP asíncrona(uso de **async y await**), URLSession(gestión de solicitudes HTTP), ScrollView, AsyncImage(carga y muestra imagenes), ProgressView(indicador de carga)
<div style="display: flex; justify-content: space-around;">
  <img src="https://github.com/user-attachments/assets/12ac3966-1962-48ba-907b-1040ef42e604" alt=" CupcakeCorner Simulator" width="35%" /> 

  <img src="https://github.com/user-attachments/assets/38f7673d-1d28-4ba1-b7ef-9b25393ab7f5" alt="Low Connection" width="45%" /> 

</div>

  
## Debugging con LLDB:

Al intentar enviar los datos de la clase Order al servidor, las claves JSON contenían un guion bajo (_), (**1ª FOTO**) lo que impedía que coincidiese con el formato esperado por la API. Se resuelve utilizando un breakpoint en LLDB(**2ª FOTO**) para rastrear el flujo de codificación y mapear con enum codingKeys en la clase Order.

<div style="display: flex; justify-content: space-around;">
  <img src="https://github.com/user-attachments/assets/5fbc99a2-649d-47fe-b7b9-2ae5137e8ba8" alt="Depuración en Xcode" width="45%" />
  <img src="https://github.com/user-attachments/assets/14ee6ae9-674d-44cd-acda-8de5deea655d" alt="Depuración en Xcode" width="45%" />
</div>




