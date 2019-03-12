import OrderService from './order.service';

const CLASSNAMES = {
    ROOT_ELEMENT: 'js-orderItem',
    ACTION_ITEM: 'js-orderItem-action',
    ACTION_ITEM_VALUE: 'js-orderItem-action-value',
    IS_PICKED_ORDER_ITEM: 'mix-orderItem_isPicked',
    ORDER_ITEM: 'orderItem',
    REMOVE_ITEM: 'js-orderItem-remove',
};

export class SingleOrderController {
    constructor() {
        const $element = document.getElementsByClassName(CLASSNAMES.ROOT_ELEMENT);

        if ($element.length === 0) {
            this.disable();

            return;
        }

        this._$actionItemElementList = null;
        this._$removeItemElementList = null;
        this._isEnabled = false;

        return this._init()
            ._createChildren()
            ._setuphandlers()
            .enable();
    }

    _init() {
        return this;
    }

    _createChildren() {
        this._$actionItemElementList = document.getElementsByClassName(CLASSNAMES.ACTION_ITEM);
        this._$removeItemElementList = document.getElementsByClassName(CLASSNAMES.REMOVE_ITEM);

        return this;
    }

    _setuphandlers() {
        this._onClickPickedCheckboxHandler = this._onClickPickedCheckbox.bind(this);
        this._onClickRemoveItemHandler = this._onClickRemoveItem.bind(this);
        this._onUpdatePickedSuccessHandler = this._onUpdatePickedSuccess.bind(this);
        this._onRemoveSuccessHandler = this._onRemoveSuccess.bind(this);

        return this;
    }

    enable() {
        if (this._isEnabled) {
            return this;
        }

        this._addHandlerToElementList(this._$actionItemElementList, this._onClickPickedCheckboxHandler);
        this._addHandlerToElementList(this._$removeItemElementList, this._onClickRemoveItemHandler);

        this._isEnabled = true;

        return this;
    }

    disable() {
        if (!this._isEnabled) {
            return this;
        }

        this._isEnabled = false;

        return this;
    }

    _addHandlerToElementList(elementList, handler) {
        if (elementList.length === 0) {
            return;
        }

        for (let i =0; i < elementList.length; i++) {
            const element = elementList[i];

            element.addEventListener('click', handler);
        }
    }

    _onClickPickedCheckbox(event) {
        event.preventDefault();

        const csrf = event.currentTarget.dataset.csrf;
        const targetElement = event.currentTarget;
        const orderItemId = event.currentTarget.dataset.orderItemId;
        const isPickedCheckboxElement = document.getElementById(orderItemId);
        const currentValue = isPickedCheckboxElement.checked;
        const orderItemUrl = `/order_items/${orderItemId}.json`;
        const itemUpdateToSend = {
            picked: !currentValue
        };

        OrderService.patch(orderItemUrl, itemUpdateToSend, csrf)
            .then((response) => {
                if (response.status !== 200) {
                    console.error(`Received an unexpected status code from ${orderItemUrl}. See response: ${response}`);

                    return;
                }

                this._onUpdatePickedSuccessHandler(
                    response.data,
                    isPickedCheckboxElement,
                    targetElement
                );
            })
            .catch((error) => { throw error; });
    }

    _onClickRemoveItem(event) {
        const orderItemId = event.currentTarget.dataset.orderItemId;
        const csrf = event.currentTarget.dataset.csrf;
        const orderItemUrl = `/order_items/${orderItemId}.json`;

        OrderService.delete(orderItemUrl, csrf)
            .then((response) => {
                if (response.status !== 204) {
                    console.error(`Received an unexpected status code from ${orderItemUrl}. See response: ${response}`);

                    return;
                }

                this._onRemoveSuccess(orderItemId);
            })
            .catch((error) => { throw error; });
    }

    _onUpdatePickedSuccess(orderItem, isPickedCheckboxElement, curentTarget) {
        const orderItemSelector = `${CLASSNAMES.ROOT_ELEMENT}-${orderItem.id}`;
        const orderItemElement = document.getElementsByClassName(orderItemSelector)[0];
        isPickedCheckboxElement.checked = orderItem.picked;

        if (orderItem.picked) {
            orderItemElement.classList.add(CLASSNAMES.IS_PICKED_ORDER_ITEM);

            return;
        }

        orderItemElement.classList.remove(CLASSNAMES.IS_PICKED_ORDER_ITEM);
    }

    _onRemoveSuccess(orderItemId) {
        const elementToRemoveSelector = `${CLASSNAMES.ROOT_ELEMENT}-${orderItemId}`;
        const elementToRemove = document.getElementsByClassName(elementToRemoveSelector)[0];

        elementToRemove.parentNode.removeChild(elementToRemove);
    }
}

document.addEventListener('turbolinks:load', () => {
    const singleOrderController = new SingleOrderController();
});
