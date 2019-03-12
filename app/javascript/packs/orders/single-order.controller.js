import OrderService from './order.service';

const CLASSNAMES = {
    ROOT_ELEMENT: 'js-orderItem',
    ACTION_ITEM: 'js-orderItem-action',
    REMOVE_ITEM: 'js-orderItem-remove',
    ORDER_ITEM_BASE: 'js-orderItem'
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
        const orderItemId = event.currentTarget.dataset.orderItemId;
        const itemUrl = `/order_items/${orderItemId}`;

        try {
            OrderService.put(itemUrl);
        } catch (error) {
            console.error(error);
        }
    }

    _onClickRemoveItem(event) {
        const orderItemId = event.currentTarget.dataset.orderItemId;
        const csrf = event.currentTarget.dataset.csrf;
        const itemUrl = `/order_items/${orderItemId}.json`;

        OrderService.delete(itemUrl, csrf)
            .then((response) => {
                if (response.status !== 204) {
                    console.error(`Received an unexpected status code from ${url}. See response: ${response}`);

                    return;
                }

                this._onRemoveSuccess(orderItemId);
            })
            .catch((error) => { throw error; });
    }

    _onRemoveSuccess(orderItemId) {
        const elementToRemoveSelector = `${CLASSNAMES.ORDER_ITEM_BASE}-${orderItemId}`;
        const elementToRemove = document.getElementsByClassName(elementToRemoveSelector)[0];

        elementToRemove.parentNode.removeChild(elementToRemove);
    }
}

document.addEventListener('turbolinks:load', () => {
    const singleOrderController = new SingleOrderController();
});
