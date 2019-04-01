import FlashController from '../flash/flash.controller';
import OrderItemModel from './order-item.model';
import ApiService from '../service/api.service';

const CLASSNAMES = {
    ROOT_ELEMENT: 'js-item',
    ACTION_ITEM: 'js-item-action',
    ADD_ITEM_TO_ORDER_FORM: 'js-item-createOrderItemForm'
};

export class OrderController {
    constructor() {
        const $element = document.getElementsByClassName(CLASSNAMES.ROOT_ELEMENT);

        if ($element.length === 0) {
            this.disable();

            return;
        }

        this._$actionItemElementList = null;
        this._flashController = new FlashController();
        this._isEnabled = false;

        return this._init()
            ._createChildren()
            ._setupHandlers()
            .enable();
    }

    _init() {
        return this;
    }

    _createChildren() {
        this._$actionItemElementList = document.getElementsByClassName(CLASSNAMES.ACTION_ITEM);

        return this;
    }

    _setupHandlers() {
        this._onClickAddItemToOrderHandler = this._onClickAddItemToOrder.bind(this);

        return this;
    }

    enable() {
        if (this._isEnabled) {
            return this;
        }

        this._addHandlerToElementList(this._$actionItemElementList, this._onClickAddItemToOrderHandler);

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

    _onClickAddItemToOrder(event) {
        event.stopPropagation();
        event.preventDefault();

        const csrf = event.currentTarget.dataset.csrf;
        const createOrderItemUrl = `/order_items/create/item.json`;
        const orderItemModel = new OrderItemModel(event.currentTarget);

        if (!orderItemModel.isValid()) {
            return;
        }

        ApiService.post(createOrderItemUrl, orderItemModel.toJson(), csrf)
            .then((response) => {
                if (response.status >= 300) {
                    console.error(`Received an unexpected status code from ${createOrderItemUrl}. See response: ${response}`);

                    return;
                }

                this._flashController.showNoticeMessage(`${orderItemModel.name} added to pending order`);
            })
            .catch((error) => {
                // TODO: add ability to set flash warning, error
                this._flashController.showNoticeMessage('Something went wrong, Item was not successfully added to Order');

                throw error;
            });
    }
}

document.addEventListener('turbolinks:load', () => {
    const singleOrderController = new OrderController();
});
