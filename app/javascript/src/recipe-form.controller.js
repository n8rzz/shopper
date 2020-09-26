const CLASSNAMES = {
    ROOT_ELEMENT: 'js-recipeForm',
    ASSEMBLY_SELECT_ELEMENT: 'js-assemblySelect',
    RECIPE_NAME_ELEMENT: 'js-recipeName',
};

export default class RecipeFormController {
    constructor() {
        // eslint-disable-next-line prefer-destructuring
        this.$element = document.getElementsByClassName(CLASSNAMES.ROOT_ELEMENT)[0];
        this._selectElement = null;
        this._nameElement = null;

        this._isEnabled = false;

        if (this.$element == null) {
            return this.disable();
        }

        return this._init()
            ._setupHandlers()
            ._createChildren()
            .enable();
    }

    _init() {
        return this;
    }

    _setupHandlers() {
        this._onChangeSelectHandler = this._onChangeSelect.bind(this);
        this._onChangeNameHandler = this._onChangeName.bind(this);

        return this;
    }

    _createChildren() {
        // eslint-disable-next-line prefer-destructuring
        this._selectElement = document.getElementById('recipe_assembly_id');
        // eslint-disable-next-line prefer-destructuring
        this._nameElement = this.$element.getElementsByClassName(CLASSNAMES.RECIPE_NAME_ELEMENT)[0];

        return this;
    }

    enable() {
        if (this._isEnabled) {
            return this;
        }

        this._isEnabled = true;

        this._selectElement.addEventListener('change', this._onChangeSelectHandler);
        this._nameElement.addEventListener('change', this._onChangeNameHandler);

        return this.layout();
    }

    disable() {
        if (!this._isEnabled) {
            return this;
        }

        this._isEnabled = false;

        this._selectElement.removeEventListener('change', this._onChangeSelectHandler);
        this._nameElement.removeEventListener('change', this._onChangeNameHandler);

        return this;
    }

    layout() {
        const isSelectActive = this._selectElement.selectedIndex !== 0;
        const isNameActive = this._nameElement.value !== '';

        this._disableActiveField(isSelectActive, isNameActive);
    }

    _disableActiveField(isSelectActive, isNameActive) {
        this._selectElement.disabled = isNameActive;
        this._nameElement.disabled = isSelectActive;
    }

    _onChangeSelect() {
        this.layout();
    }

    _onChangeName() {
        this.layout();
    }
}

document.addEventListener('turbolinks:load', () => new RecipeFormController());
