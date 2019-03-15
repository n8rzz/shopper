import ApiService from '../service/api.service';
import AssemblyItemCollection from './assembly-item.collection';
import AssemblyItemView from './assembly-item.view';

const CLASSNAMES = {
    TRIGGER_ELEMENT: 'js-addAssemblyItemToOrder',
};

export default class AssemblyItemController {
    constructor() {
        const $elementList = document.getElementsByClassName(CLASSNAMES.TRIGGER_ELEMENT);
        this._collection = new AssemblyItemCollection();
        this._isEnabled = false;

        if ($elementList.length === 0) {
            return this.disable();
        }

        return this._init()
            ._setupHandlers()
            ._createChildren($elementList)
            .enable();
    }

    _init() {
        return this;
    }

    _setupHandlers() {
        this._onClickHandler = this._onClick.bind(this);

        return this;
    }

    _createChildren($elementList) {
        for (let i = 0; i < $elementList.length; i++) {
            const element = $elementList[i];
            const viewModel = new AssemblyItemView(element, this._onClickHandler);

            this._collection.add(viewModel);
        }

        return this;
    }

    enable() {
        if (this._isEnabled) {
            return this;
        }

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

    _onClick(event) {
        event.preventDefault();

        const csrf = event.currentTarget.dataset.csrf;
        const assemblyId = event.currentTarget.dataset.assemblyId;
        const assemblyItemId = event.currentTarget.dataset.assemblyItemId;
        const departmentId = event.currentTarget.dataset.departmentId
        const assemblyItemUrl = `/order_items/create/item.json`;
        const requestPayload = {
            assembly_id: assemblyId,
            department_id: departmentId,
            item_id: assemblyItemId
        };

        ApiService.post(assemblyItemUrl, requestPayload, csrf)
            .then((response) => {
                if (response.status >= 300) {
                    console.error(`Received an unexpected status code from ${assemblyItemUrl}. See response: `, response);

                    return;
                }

                this._onAddItemSuccess(requestPayload, response);
            })
            .catch((error) => { throw error; });
    }

    _onAddItemSuccess(requestPayload, response) {
        console.log(requestPayload, response);
    }
}

document.addEventListener('turbolinks:load', () => {
    const assemblyItemController = new AssemblyItemController();
});
