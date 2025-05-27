$(document).ready(function () {
    // Eliminar producto
    $(".cart-container").on("click", "#btnDelete", function () {
    var idp = $(this).closest(".cart-item").find("input[type='hidden']").val();

    // SweetAlert
    Swal.fire({
        title: "¿Estás seguro?",
        text: "¡No podrás revertir esto!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Sí, ¡elimínalo!",
        cancelButtonText: "Cancelar"
    }).then((result) => {
        if (result.isConfirmed) {
            eliminar(idp);
            Swal.fire({
                title: "¡Eliminado!",
                text: "El producto ha sido eliminado.",
                icon: "success"
            }).then((result) => {
                if (result.isConfirmed) {
                    parent.location.href = "Controlador?accion=VerCarrito";
                }
            });
        }
    });
});

function eliminar(idp) {
    var url = "Controlador?accion=Delete";
    $.ajax({
        type: 'POST',
        url: url,
        data: { idp: idp }, // Enviar datos en formato clave-valor
        success: function (data, textStatus, jqXHR) {
            console.log("Producto eliminado exitosamente");
        }
    });
}


    // Botón para aumentar la cantidad
    $(".btn-plus").on('click', function () {
        var inputCantidad = $(this).parent().find("#Cantidad");
        var nuevaCantidad = parseInt(inputCantidad.val()) + 1;  // Incrementar el valor de la cantidad
        inputCantidad.val(nuevaCantidad);  // Actualizar el valor en el input

        actualizarCantidad(inputCantidad);
    });

// Botón para disminuir la cantidad
    $(".btn-minus").on('click', function () {
        var inputCantidad = $(this).parent().find("#Cantidad");
        var nuevaCantidad = parseInt(inputCantidad.val()) - 1;  // Decrementar el valor de la cantidad
        if (nuevaCantidad < 1)
            nuevaCantidad = 1;  // No permitir cantidades menores a 1
        inputCantidad.val(nuevaCantidad);  // Actualizar el valor en el input

        actualizarCantidad(inputCantidad);
    });

// Cambio directo en el input de cantidad
    $("input#Cantidad").on('change', function () {
        if ($(this).val() < 1) {
            $(this).val(1);  // Evitar que el valor sea menor a 1
        }
        actualizarCantidad($(this));
    });

// Función para enviar la nueva cantidad al servidor
    function actualizarCantidad(inputElement) {
        var idp = inputElement.closest(".cart-item").find("input#idp").val();  // Capturar el id del producto
        var cantidad = inputElement.val();  // Capturar el valor del input de cantidad

        var url = "Controlador?accion=ActualizarCantidad";  // URL del controlador para la actualización
        $.ajax({
            type: "POST",
            url: url,
            data: {idp: idp, Cantidad: cantidad},
            dataType: "json",
            success: function (response) {
                // Actualizar solo el valor del subtotal, sin eliminar la palabra "Subtotal"
                inputElement.closest(".cart-item").find(".subtotal-amount").text(response.subtotal.toFixed(2));

                // Actualizar el total general
                $("#total").text("S/. " + response.totalPagar.toFixed(2));
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("Error al actualizar la cantidad.");
            }
        });
    }



    // Eliminar de BDD
    $(document).on("click", ".delete", function () {
        var idProducto = $(this).closest("tr").find("input[type=checkbox]").val();
        $("#idProductoEliminar").val(idProducto);
    });

    // Función para calcular el total a pagar
    function calcularTotal() {
        let total = 0;
        const subtotales = document.querySelectorAll('.subtotal');

        subtotales.forEach((subtotal) => {
            // Extraemos el valor numérico del subtotal (sin el símbolo de moneda)
            const valor = parseFloat(subtotal.textContent.replace('S/.', '').trim());
            total += valor;
        });

        return total;
    }
});
