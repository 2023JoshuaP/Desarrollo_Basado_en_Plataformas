using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Desarrollo_Basado_en_Plataformas.ServiceReference1;
using Desarrollo_Basado_en_Plataformas.ServiceReference2;

namespace Registro
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //string filePath = Server.MapPath("~/App_Data/Lista.txt");
                string[] ciudades = serviceCall();//File.ReadAllLines(filePath);

                foreach (string ciudad in ciudades)
                {
                    DropDownListCiudad.Items.Add(new ListItem(ciudad, ciudad));
                }
            }
        }
        private String[] serviceCall()
        {
            Service1Client client = new Service1Client();
            String[] ciudades = client.getCiudades();
            return ciudades;
        }
        protected void ButtonEnviar_Click(object sender, EventArgs e)
        {
            string nombres = Text1.Text;
            string apellidos = Text2.Text;
            string sexo = RadioButtonM.Checked ? "Masculino" : "Femenino";
            string correo = Text3.Text;
            string direccion = TextDireccion.Text;
            string ciudad = DropDownListCiudad.SelectedValue;
            string requerimientos = TextRequerimientos.Text;

            Service2Client client = new Service2Client();
            client.RegistroDatos(nombres, apellidos, sexo, correo, direccion, ciudad, requerimientos);

            StringBuilder datosRegistrados = new StringBuilder();
            datosRegistrados.AppendLine($"Nombres: {nombres}");
            datosRegistrados.AppendLine($"Apellidos: {apellidos}");
            datosRegistrados.AppendLine($"Sexo: {sexo}");
            datosRegistrados.AppendLine($"Correo: {correo}");
            datosRegistrados.AppendLine($"Dirección: {direccion}");
            datosRegistrados.AppendLine($"Ciudad: {ciudad}");
            datosRegistrados.AppendLine($"Requerimientos: {requerimientos}");

            TextBoxDatosRegistrados.Text = datosRegistrados.ToString();

            Text1.Text = string.Empty;
            Text2.Text = string.Empty;
            RadioButtonM.Checked = false;
            RadioButtonF.Checked = false;
            Text3.Text = string.Empty;
            TextDireccion.Text = string.Empty;
            DropDownListCiudad.SelectedValue = "0";
            TextRequerimientos.Text = string.Empty;
        }
    }
}