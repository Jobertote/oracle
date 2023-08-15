DECLARE
   lvMensaje         VARCHAR2(4000);
   leException       EXCEPTION;
BEGIN

   -- Se crea un For para hacer un recorrido de registros y actualizarlos
   FOR cTableName IN (SELECT tab._Key,
                             tab.field
                        FROM esqumea.table tab
                       WHERE tab.field = 'field')
   LOOP
      UPDATE esquema.table
         SET field = 'field'
       WHERE field = cTableName._key;
   END LOOP;

   --Se hace un commit para guardar los cambios
   Commit;
EXCEPTION
   WHEN leException THEN
      --En caso de que un error ocurra se hace un rollBack
      RollBack;
      RAISE_APPLICATION_ERROR(-20001, lvMensaje);
   WHEN OTHERS THEN
      RollBack;
      RAISE_APPLICATION_ERROR(-20001, 'Error no controlado al actualizar los datos: ' || SqlErrm);
END;
