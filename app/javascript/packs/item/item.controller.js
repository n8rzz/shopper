import FlashController from '../flash/flash.controller';
import OrderItemModel from './order-item.model';
import ApiService from '../service/api.service';
import StepperView from '../stepper/stepper.view';

const CLASSNAMES = {
    ROOT_ELEMENT: 'js-item',
    ACTION_ITEM: 'js-item-action',
    ADD_ITEM_TO_ORDER_FORM: 'js-item-createOrderItemForm',
    STEPPER_ROOT: 'js-stepper',
};

export class OrderController {
    constructor() {
        const $element = document.getElementsByClassName(CLASSNAMES.ROOT_ELEMENT);

        if ($element.length === 0) {
            this.disable();

            return;
        }

        this._$stepperElementList = [];
        this._flashController = new FlashController();
        this._isEnabled = false;
        this._items = [];

        return this._init()
            ._createChildren()
            ._setupHandlers()
            .enable();
    }

    _init() {
        return this;
    }

    _createChildren() {
        this._$stepperElementList = new Array(...document.getElementsByClassName(CLASSNAMES.STEPPER_ROOT));

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

        this._addHandlerToElementList(this._$stepperElementList, this._onClickAddItemToOrderHandler);

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

        this._items = this._$stepperElementList.map((element) => new StepperView(element, handler));
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
