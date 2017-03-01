
/*Home*/
/*Total cargadas en un año y los en meses en curso*/
select	'Son'=count(maecuentas.TWSCodDeudor)
/*select	maecuentas.TWSCodDeudor,'fechRecep'=convert(char(12),maecuentas.FechRecepcion,103)*/
from	MaeCuentas,MaeDocumentos 
where	MaeCuentas.NAcree=5601369/*Cliente que ingresa al portal*/
and		(DATEDIFF(yyyy,Maecuentas.FechRecepcion,getdate())<2 /*Un año completo*/
OR 		DATEPART(YYYY,MaeCuentas.FechRecepcion)=YEAR(getdate()))/*Los meses en curso*/
and		MaeCuentas.TWSCodDeudor=MaeDocumentos.TWSCodDeudor 
and		MaeCuentas.NCuenta=MaeDocumentos.NCuenta 
and		MaeDocumentos.TipoDoc<>13
and		MaeCuentas.TipoCobranza=2/*prejudicial*/


/*Cuanto suma lo cargado en un año  y los en meses en curso*/
select 
(select	'Monto total'=sum(maedocumentos.Monto)
from	MaeCuentas,MaeDocumentos
where	MaeCuentas.NAcree =5601369
and		(DATEDIFF(yyyy,Maecuentas.FechRecepcion,getdate())<2 /*Un año completo*/
OR 		DATEPART(YYYY,MaeCuentas.FechRecepcion)=YEAR(getdate()))/*Los meses en curso*/
and		MaeCuentas.TWSCodDeudor=MaeDocumentos.TWSCodDeudor 
and		MaeCuentas.NCuenta=MaeDocumentos.NCuenta 
and		MaeDocumentos.TipoDoc<>13
and		maedocumentos.Moneda=33
and		MaeCuentas.TipoCobranza=2)/*prejudicial*/
+
(select	'Monto total'=isnull(sum((maedocumentos.Monto*lstmonedas.Valor)),0)
from	MaeCuentas,MaeDocumentos,lstMonedas 
where	MaeCuentas.NAcree =5601369
and		(DATEDIFF(yyyy,Maecuentas.FechRecepcion,getdate())<2 /*Un año completo*/
OR 		DATEPART(YYYY,MaeCuentas.FechRecepcion)=YEAR(getdate()))/*Los meses en curso*/
and		MaeCuentas.TWSCodDeudor=MaeDocumentos.TWSCodDeudor 
and		MaeCuentas.NCuenta=MaeDocumentos.NCuenta 
and		MaeDocumentos.TipoDoc<>13
and		maedocumentos.Moneda<>33
and		maedocumentos.Moneda=lstMonedas.Codigo 
and		MaeCuentas.TipoCobranza=2)/*prejudicial*/
/*Fin Home*/


/*Estadística (Reportes)*/
/*Filtrar según el rango de fechas ingresado en pantalla*/

/*Total cobradas*/
select 'Son'=count(Maedocumentos.TWSCodDeudor)
/*select	maecuentas.TWSCodDeudor,maecuentas.NCuenta,'fechRecep'=convert(char(12),maecuentas.FechRecepcion,103)*/
from	MaeCuentas,MaeDocumentos 
where	MaeCuentas.NAcree =5601369
and		Maecuentas.FechRecepcion>='01/01/2017' /*rango de años*/
and		Maecuentas.FechRecepcion<'01/03/2017' /*rango de años*/
and		MaeCuentas.TWSCodDeudor=MaeDocumentos.TWSCodDeudor 
and		MaeCuentas.NCuenta=MaeDocumentos.NCuenta 
and		MaeDocumentos.SaldoDoc=0
and		MaeDocumentos.StatusDoc=2/*pagado*/
and		MaeDocumentos.TipoDoc<>13
and		MaeCuentas.TipoCobranza=2/*prejudicial*/

/*Monto del total cobrado*/
select 
(select 'Monto total'=sum(maedocumentos.Monto)
/*select	maecuentas.TWSCodDeudor,maecuentas.NCuenta,'fechRecep'=convert(char(12),maecuentas.FechRecepcion,103)*/
from	MaeCuentas,MaeDocumentos  
where	MaeCuentas.NAcree =5601369
and		Maecuentas.FechRecepcion>='01/01/2017' /*rango de años*/
and		Maecuentas.FechRecepcion<'01/03/2017' /*rango de años*/
and		MaeCuentas.TWSCodDeudor=MaeDocumentos.TWSCodDeudor 
and		MaeCuentas.NCuenta=MaeDocumentos.NCuenta 
and		MaeDocumentos.SaldoDoc=0
and		MaeDocumentos.StatusDoc=2/*pagado*/
and		MaeDocumentos.TipoDoc<>13
and		maedocumentos.Moneda=33
and		MaeCuentas.TipoCobranza=2) /*prejudicial*/
+
(select 'Monto total'=isnull(sum((maedocumentos.Monto*lstmonedas.Valor)),0)
/*select	maecuentas.TWSCodDeudor,maecuentas.NCuenta,'fechRecep'=convert(char(12),maecuentas.FechRecepcion,103)*/
from	MaeCuentas,MaeDocumentos,lstMonedas  
where	MaeCuentas.NAcree =5601369
and		Maecuentas.FechRecepcion>='01/01/2017' /*rango de años*/
and		Maecuentas.FechRecepcion<'01/03/2017' /*rango de años*/
and		MaeCuentas.TWSCodDeudor=MaeDocumentos.TWSCodDeudor 
and		MaeCuentas.NCuenta=MaeDocumentos.NCuenta 
and		MaeDocumentos.SaldoDoc=0
and		MaeDocumentos.StatusDoc=2/*pagado*/
and		MaeDocumentos.TipoDoc<>13
and		maedocumentos.Moneda<>33
and		maedocumentos.Moneda=lstMonedas.Codigo
and		MaeCuentas.TipoCobranza=2)/*prejudicial*/

/*Total pendientes*/
select 'Son'=count(Maedocumentos.Monto)
/*select	maecuentas.TWSCodDeudor,maecuentas.NCuenta,'fechRecep'=convert(char(12),maecuentas.FechRecepcion,103)*/
from	MaeCuentas,MaeDocumentos 
where	MaeCuentas.NAcree =5601369
and		Maecuentas.FechRecepcion>='01/01/2017' /*rango de años*/
and		Maecuentas.FechRecepcion<'01/03/2017' /*rango de años*/
and		MaeCuentas.TWSCodDeudor=MaeDocumentos.TWSCodDeudor 
and		MaeCuentas.NCuenta=MaeDocumentos.NCuenta 
and		MaeDocumentos.SaldoDoc>0
and		MaeDocumentos.StatusDoc<>2/*pagado*/
and		MaeCuentas.StatusCta=1
and		MaeDocumentos.TipoDoc<>13
and		MaeCuentas.TipoCobranza=2/*prejudicial*/

/*Monto del total pendiente*/
select 'Monto total'=sum((maedocumentos.Monto*lstmonedas.Valor))
/*select	maecuentas.TWSCodDeudor,maecuentas.NCuenta,'fechRecep'=convert(char(12),maecuentas.FechRecepcion,103)*/
from	MaeCuentas,MaeDocumentos,lstMonedas  
where	MaeCuentas.NAcree =5601369
and		Maecuentas.FechRecepcion>='01/01/2017' /*rango de años*/
and		Maecuentas.FechRecepcion<'01/03/2017' /*rango de años*/
and		MaeCuentas.TWSCodDeudor=MaeDocumentos.TWSCodDeudor 
and		MaeCuentas.NCuenta=MaeDocumentos.NCuenta 
and		MaeDocumentos.SaldoDoc>0
and		MaeDocumentos.StatusDoc<>2/*pagado*/
and		MaeCuentas.StatusCta=1
and		MaeDocumentos.TipoDoc<>13
and		maedocumentos.Moneda=lstMonedas.Codigo 
and		MaeCuentas.TipoCobranza=2/*prejudicial*/


/*Incobrables*/

/*Total incobrables*/
select 'Son'=count(Maedocumentos.Monto)
/*select	maecuentas.TWSCodDeudor,maecuentas.NCuenta,'fechRecep'=convert(char(12),maecuentas.FechRecepcion,103)*/
from	MaeCuentas,MaeDocumentos 
where	MaeCuentas.NAcree=5601369
and		Maecuentas.FechRecepcion>='01/01/2017' /*rango de años*/
and		Maecuentas.FechRecepcion<'01/03/2017' /*rango de años*/
and 	MaeCuentas.TWSCodDeudor=MaeDocumentos.TWSCodDeudor 
and		MaeCuentas.NCuenta=MaeDocumentos.NCuenta 
and		MaeDocumentos.SaldoDoc>0
and		MaeDocumentos.StatusDoc=44/*pagado*/
and		MaeCuentas.StatusCta=1
and		MaeDocumentos.TipoDoc<>13
and		MaeCuentas.TipoCobranza=2/*prejudicial*/

/*Monto Total incobrables*/
select 'Monto total'=sum((maedocumentos.Monto*lstmonedas.Valor))
/*select	maecuentas.TWSCodDeudor,maecuentas.NCuenta,'fechRecep'=convert(char(12),maecuentas.FechRecepcion,103)*/
from	MaeCuentas,MaeDocumentos,lstMonedas 
where	MaeCuentas.NAcree=5601369
and		Maecuentas.FechRecepcion>='01/01/2017' /*rango de años*/
and		Maecuentas.FechRecepcion<'01/03/2017' /*rango de años*/
and 	MaeCuentas.TWSCodDeudor=MaeDocumentos.TWSCodDeudor 
and		MaeCuentas.NCuenta=MaeDocumentos.NCuenta 
and		MaeDocumentos.SaldoDoc>0
and		MaeDocumentos.StatusDoc=44/*pagado*/
and		MaeCuentas.StatusCta=1
and		MaeDocumentos.TipoDoc<>13
and		maedocumentos.Moneda=lstMonedas.Codigo 
and		MaeCuentas.TipoCobranza=2/*prejudicial*/


/*Total castigadas*/
select 'Son'=count(Maedocumentos.Monto)
/*select	maecuentas.TWSCodDeudor,maecuentas.NCuenta,'fechRecep'=convert(char(12),maecuentas.FechRecepcion,103)*/
from	MaeCuentas,MaeDocumentos 
where	MaeCuentas.NAcree=5601369
and		Maecuentas.FechRecepcion>='01/01/2017' /*rango de años*/
and		Maecuentas.FechRecepcion<'01/03/2017' /*rango de años*/
and 	MaeCuentas.TWSCodDeudor=MaeDocumentos.TWSCodDeudor 
and		MaeCuentas.NCuenta=MaeDocumentos.NCuenta 
and		MaeDocumentos.SaldoDoc>0
and		MaeDocumentos.StatusDoc=4/*pagado*/
and		MaeCuentas.StatusCta=4
and		MaeDocumentos.TipoDoc<>13
and		MaeCuentas.TipoCobranza=2/*prejudicial*/

/*Total monto castigadas*/
select 'Monto total'=sum((maedocumentos.Monto*lstmonedas.Valor))
/*select	maecuentas.TWSCodDeudor,maecuentas.NCuenta,'fechRecep'=convert(char(12),maecuentas.FechRecepcion,103)*/
from	MaeCuentas,MaeDocumentos,lstMonedas 
where	MaeCuentas.NAcree=5601369
and		Maecuentas.FechRecepcion>='01/01/2017' /*rango de años*/
and		Maecuentas.FechRecepcion<'01/03/2017' /*rango de años*/
and 	MaeCuentas.TWSCodDeudor=MaeDocumentos.TWSCodDeudor 
and		MaeCuentas.NCuenta=MaeDocumentos.NCuenta 
and		MaeDocumentos.SaldoDoc>0
and		MaeDocumentos.StatusDoc=4/*pagado*/
and		MaeCuentas.StatusCta=4
and		MaeDocumentos.TipoDoc<>13
and		maedocumentos.Moneda=lstMonedas.Codigo 
and		MaeCuentas.TipoCobranza=2/*prejudicial*/

/*Llenar nombre de los deudores y sus facturas, según el rango de fechas*/
select	Maerut.Nombre,'Monto'=maedocumentos.SaldoDoc,maerut.Rutsd,maerut.Digito,MaeDocumentos.TWSCodDeudor,MaeDocumentos.NCuenta   
from	MaeRut,MaeDocumentos,MaeCuentas 
where	MaeCuentas.NAcree=5601369
and		Maecuentas.FechRecepcion>='01/01/2017' /*rango de años*/
and		Maecuentas.FechRecepcion<'01/03/2017' /*rango de años*/
and 	MaeCuentas.TWSCodDeudor=MaeDocumentos.TWSCodDeudor 
and		MaeCuentas.NCuenta=MaeDocumentos.NCuenta 
and		Maerut.TwsCod=MaeCuentas.TWSCodDeudor 
and		MaeDocumentos.TipoDoc<>13
and		MaeCuentas.TipoCobranza=2/*prejudicial*/

/*Creo que la columna mandante del bosquejo, estaría demás ya que es el cliente que ingresa al portal*/

/*Gestiones de un deudor seleccionado*/
select	Gestiones.NGestion,Gestiones.FechIng,Gestiones.FechProx,maetextos.DescEsp
from	Gestiones,Maetextos,MaeCuentas 
where	MaeCuentas.NAcree=5601369
/*and		Maecuentas.FechRecepcion>='01/01/2017' /*rango de años*/
and		Maecuentas.FechRecepcion<'01/03/2017' /*rango de años*/*/
and		MaeCuentas.TWSCodDeudor=7083  /*Deudor capturado al seleccionar el deudor en la pantalla*/
and		MaeCuentas.NCuenta=517        /*cuenta capturada al seleccionar el deudor en la pantalla*/
and		MaeCuentas.TWSCodDeudor=Gestiones.TWSCodDeudor 
and		MaeCuentas.NCuenta=Gestiones.NCuenta 
and		Maetextos.TWSCod=Gestiones.TWSCodDeudor 
and		Maetextos.NCuenta=Gestiones.NCuenta 
and		Gestiones.NGestion=Maetextos.LoopID 
and		MaeCuentas.TipoCobranza=2/*prejudicial*/
