export default class OrderItemModel {
    constructor(element) {
        this.itemId = -1;
        this.name = '';
        this.departmentId = -1;
        this.qty = -1;

        return this._init(element);
    }

    isValid() {
        return this.itemId !== -1
            && this.departmentId !== -1
            && this.qty !== -1
            && this.qty > 0;
    }

    toJson() {
        return {
            item_id: this.itemId,
            department_id: this.departmentId,
            qty: this.qty,
        };
    }

    _init(element) {
        this.itemId = parseInt(element.dataset.itemId, 10);
        this.name = element.dataset.itemName;
        this.departmentId = parseInt(element.dataset.departmentId, 10);
        this.qty = this._extractAndSetQty();

        return this;
    }

    _extractAndSetQty() {
        const qtyElement = document.getElementById(`item-${this.itemId}-qty`);

        return parseInt(qtyElement.value, 10);
    }
}
