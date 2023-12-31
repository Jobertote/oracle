DECLARE   
   lvMensaje         VARCHAR2(4000);
   leException       EXCEPTION;
   lnKey             NUMBER;
BEGIN
--Bloque para seleccionar una key con base 
   Select _key
     Into lnKey
     From esquema.tabla
    Where campo = 'campo';

 --Bloque para actualizar un campo comparando la key seleccionada en el bloque anterior    
    UPDATE esquema.tabla 
       SET campo = 'campo'
     WHERE -key = lnKey
       AND campo = 'campo';

  --Bloque que valida si el bloque anterior actualizo el numero correcto de filas     
    If Sql%RowCount != 1 Then
      lvMensaje := 'Error al actualizar los campos.';
      Raise leException;
    End If;          

  --Confirmacion de los cambios 
   Commit;
EXCEPTION
   WHEN leException THEN
      RollBack;
      RAISE_APPLICATION_ERROR(-20001, lvMensaje);
   WHEN OTHERS THEN
      RollBack;
      RAISE_APPLICATION_ERROR(-20001, 'Error no controlado al actualizar los datos: ' || SqlErrm);
END;
