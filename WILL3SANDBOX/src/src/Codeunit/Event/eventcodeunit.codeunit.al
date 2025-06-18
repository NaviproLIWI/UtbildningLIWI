codeunit 50210 MyCodeunit
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Whse. Post Shipment", OnInitSourceDocumentHeaderOnBeforeSalesHeaderModify, '', false, false)]
    local procedure "Sales Whse. Post Shipment_OnInitSourceDocumentHeaderOnBeforeSalesHeaderModify"(var SalesHeader: Record "Sales Header"; var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var ModifyHeader: Boolean; WhsePostParameters: Record "Whse. Post Parameters" temporary; var WarehouseShipmentLine: Record "Warehouse Shipment Line")
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Whse. Post Shipment", OnInitSourceDocumentHeaderOnBeforeReopenSalesHeader, '', false, false)]
    local procedure "Sales Whse. Post Shipment_OnInitSourceDocumentHeaderOnBeforeReopenSalesHeader"(var SalesHeader: Record "Sales Header"; WhsePostParameters: Record "Whse. Post Parameters" temporary; var NewCalledFromWhseDoc: Boolean)
    begin
    end;






    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Whse. Post Shipment", OnAfterFindWhseShptLineForSalesLine, '', false, false)]
    local procedure "Sales Whse. Post Shipment_OnAfterFindWhseShptLineForSalesLine"(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; var SalesLine: Record "Sales Line")
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnBeforePostSourceHeader, '', false, false)]
    local procedure "Whse.-Post Shipment_OnBeforePostSourceHeader"(var WhseShptLine: Record "Warehouse Shipment Line"; GlobalSourceHeader: Variant; WhsePostParameters: Record "Whse. Post Parameters" temporary)
    begin
    end;
    
    
    
    
}