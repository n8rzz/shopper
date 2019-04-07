/**
 * Accepts a DOM element (`currentTarget` from a click event) and
 * extracts information from that DOM element used in submission
 * of a form.
 *
 * This model acts as a flyweight and should only be available
 * between mouse click and api request.
 *
 * @class OrderItemModel
 */
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
        this.qty = this._extractQtyFromInputElement();

        return this;
    }

    _extractQtyFromInputElement() {
        const qtyElement = document.getElementById(`item-${this.itemId}-qty`);

        return parseInt(qtyElement.value, 10);
    }
}
