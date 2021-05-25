Attribute VB_Name = "Módulo1"
Dim ie As Object

Sub cciexploc()
Set ie = CreateObject("INTERNETEXPLORER.APPLICATION")
ie.NAVIGATE "https://es.wikipedia.org/wiki/Anexo:Pa%C3%ADses_de_Am%C3%A9rica_por_superficie"
ie.Visible = True
End Sub

Sub ie_getElementById()
[a19] = ie.document.getElementById("pt-anontalk").innerText
End Sub

Sub ie_getElementsByTagName()
[a20] = ie.document.getElementsByTagName("li")(2).innerText
End Sub

Sub ie_getElementsByClassName()
Debug.Print ie.document.getElementsByClassName("firstHeading")(0).innerText
End Sub

Sub ie_id_tag()
Debug.Print ie.document.getElementById("mw-content-text").getElementsByTagName("tr")(4).innerText
End Sub

Sub etiqueta_td_tr()
Debug.Print ie.document.getElementById("mw-content-text").getElementsByTagName("tr")(2).getElementsByTagName("td")(2).innerText
End Sub

Sub contar_tr()
Debug.Print ie.document.getElementById("mw-content-text").getElementsByTagName("tr").Length
End Sub

Sub contar_td()
Debug.Print ie.document.getElementById("mw-content-text").getElementsByTagName("td").Length
End Sub

Sub contar_tdtr()
Debug.Print ie.document.getElementById("mw-content-text").getElementsByTagName("tr")(1).getElementsByTagName("td").Length
End Sub

Sub etiqueta_td_for()
For i = 0 To 3
Debug.Print ie.document.getElementById("mw-content-text").getElementsByTagName("tr")(i).innerText
Next
End Sub

Sub ie_td_tr_for()
For i = 0 To 3
For j = 0 To 3
Cells(i + 1, j + 1) = ie.document.getElementById("mw-content-text").getElementsByTagName("tr")(i).getElementsByTagName("td")(j).innerText
Next
Next
End Sub

Sub todo()
Set ie1 = CreateObject("INTERNETEXPLORER.APPLICATION")
ie1.Visible = True
ie1.NAVIGATE "https://es.wikipedia.org/wiki/Anexo:Pa%C3%ADses_de_Am%C3%A9rica_por_superficie"
        While ie1.ReadyState <> 4
            DoEvents
        Wend
[a26] = ie1.document.getElementById("pt-anontalk").innerText
ie1.Quit
End Sub
