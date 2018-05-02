<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="angularJS_teste.aspx.cs" Inherits="Cockpit_gpx.angularJS_teste" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <title>Exemplo de Uso Angular</title>

    <style>
        table, th, td
        {
            border: 1px solid green;
            border-collapse: collapse;
            padding: 5px;
        }
        table th
        {
            background-color: #3d3d3d;
            color: balck;
        }
        table tr:nth-child(odd)
        {
            background-color: #5d5d5d;
        }
        table tr:nth-child(even)
        {
            background-color: #2f5d4c;
        }
    </style>

</head>

<body>

    <form id="form1" runat="server">

    <div ng-app="MeuApp" ng-controller="meuCtrl">
        <table>
            <tr>
                <td>
                    Nome :
                </td>
                <td>
                    <input type="text" id="txtstr_nome_cliente" ng-model="ClientenNome" />
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="button" value="Salvar" ng-click="Salvar()" />
                </td>
            </tr>
        </table>
        <br />
        <br />
        <table>
            <thead>
                <tr>
                    <th>
                        ID
                    </th>
                    <th>
                        Nome Cliente
                    </th>
                    <th>
                    </th>
                </tr>
            </thead>
            <tr ng-repeat="cliente in Lista_de_Cliente | orderBy : cliente_ordenacao ">
                <td ng-bind="cliente.num_id">
                </td>
                <td ng-bind="cliente.str_nome_cliente">
                </td>
                <td>
                    <a href="#" ng-click="Delete(cliente.num_id)">Apagar</a>
                </td>
            </tr>
        </table>
    </div>

        <%--<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js"></script>--%>
    <script src="Scripts/angular.min.js" type="text/javascript"></script>
    <script>
        var app = angular.module("MeuApp", []);

        app.controller("meuCtrl", function ($scope, $http) {
            $scope.cliente_ordenacao = "num_id";
            $scope.ClientenNome = "";

            $scope.Salvar = function () {

                var apihttpreq = {
                    method: 'POST',
                    url: 'angularJS_teste.aspx/Salvar',
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                             },
                    data: { str_nome_cliente: $scope.ClientenNome }
                }

                $http(apihttpreq).success(function (response) {
                    $scope.PreencheListaCliente();
                    alert("Salvo com sucesso.");
                })

            };

            $scope.Delete = function (SID) {
                if (confirm("Você tem certeza que deseja apagar ?")) {
                    var apihttpreq = {
                        method: 'POST',
                        url: 'angularJS_teste.aspx/Delete',
                        headers: {
                            'Content-Type': 'application/json; charset=utf-8',
                            'dataType': 'json'
                        },
                        data: { num_id: SID }
                    }
                    $http(apihttpreq).success(function (response) {
                        $scope.PreencheListaCliente();
                        alert("Apagado com sucesso.");
                    })
                }
            };

            $scope.PreencheListaCliente = function () {
                $scope.ClientenNome = "";
                var apihttpreq = {
                    method: 'POST',
                    url: 'angularJS_teste.aspx/PegarLista',
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: {}
                }
                $http(apihttpreq).success(function (response) {
                    $scope.Lista_de_Cliente = response.d;
                })
            };

            $scope.PreencheListaCliente();

        });


    </script>

    </form>

</body>

</html>