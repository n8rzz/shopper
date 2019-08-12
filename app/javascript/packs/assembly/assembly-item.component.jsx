import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';

const BUTTON_VALUE_MAP = {
    DEFAULT: 'Add to order',
    IS_SUBMITTING: 'Adding...',
    SUCCESS: 'Success!',
};

export class AssemblyItem extends React.Component {
    _buildAssemblyButtonText() {
        if (this.props.isSubmitAssemblySuccess) {
            return BUTTON_VALUE_MAP.SUCCESS;
        }

        return !this.props.isSubmittingAssembly
            ? BUTTON_VALUE_MAP.DEFAULT
            : BUTTON_VALUE_MAP.IS_SUBMITTING;
    }

    _buildAssemblyItemButtonText(assemblyItemId) {
        if (
            this.props.isAssemblyItemSubmitSuccess
            && this.props.submittedAssemblyItemId === assemblyItemId
        ) {
            return BUTTON_VALUE_MAP.SUCCESS;
        }

        return this.props.submittedAssemblyItemId !== assemblyItemId
            ? BUTTON_VALUE_MAP.DEFAULT
            : BUTTON_VALUE_MAP.IS_SUBMITTING;
    }

    _buildAssemblyButtonClassnames() {
        return classnames({
            btn: true,
            'btn-toggle': true,
            'mix-btn_isLoading': this.props.isSubmittingAssembly,
            'mix-btn_isSuccess': this.props.isSubmitAssemblySuccess,
        });
    }

    _buildAssemblyItemButtonClassnames(assemblyItemId) {
        const isSuccess = this.props.isAssemblyItemSubmitSuccess
            && this.props.submittedAssemblyItemId === assemblyItemId;

        return classnames({
            btn: true,
            'btn-toggle': true,
            'mix-btn_isLoading': !isSuccess && this.props.submittedAssemblyItemId === assemblyItemId,
            'mix-btn_isSuccess': isSuccess,
        });
    }

    _buildAssemblyGroupHeaderJsx() {
        const assemblyItemList = this.props.assemblyItemsGroupedByAssemblyId[this.props.assembly.id];
        const buttonText = this._buildAssemblyButtonText();

        return (
            <div className={`listItem js-assembly-${this.props.assembly.id}`}>
                <div className={'listItem-hd'}>
                    <h2
                        className={'hdg hdg_2'}
                        onClick={this.props.onClickAccordionTriggerHandler}
                    >
                        {this.props.assembly.name}
                    </h2>
                    <div>
                        <button
                            type={'button'}
                            className={this._buildAssemblyButtonClassnames()}
                            data-assembly-id={this.props.assembly.id}
                            onClick={this.props.onClickAddAssemblyHandler}
                        >
                            {buttonText}
                        </button>
                    </div>
                </div>
                <div className={'listItem-ft'}>
                    <ul className={'stereo'}>
                        <li>
                            Items:
                            {assemblyItemList.length}
                        </li>
                        <li>
                            <a
                                className={'link'}
                                href={`/assemblies/${this.props.assembly.id}/edit`}
                            >
                                Edit Assembly
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        );
    }

    _buildAssemblyItemList() {
        const assemblyItemList = this.props.assemblyItemsGroupedByAssemblyId[this.props.assembly.id];
        const assemblyItemListJsx = assemblyItemList.map((assemblyItem, index) => {
            const item = this.props.itemIdMap[assemblyItem.item_id];
            const departmentName = this.props.departmentIdMap[item.department_id].name;
            const buttonText = this._buildAssemblyItemButtonText(assemblyItem.id);
            const buttonClassnames = this._buildAssemblyItemButtonClassnames(assemblyItem.id);

            return (
                <li
                    key={`assemblyItem-${index}`}
                    className={`listItem listItem-child js-assemblyItem-${assemblyItem.id}`}
                >
                    <div className={'listItem-hd'}>
                        <h3 className={'hdg'}>
                            {item.name}
                        </h3>
                    </div>
                    <div className={'listItem-ft'}>
                        <ul className={'stereo'}>
                            <li>
                                {departmentName}
                            </li>
                            <li>
                                <button
                                    type={'button'}
                                    className={buttonClassnames}
                                    data-department-id={item.department_id}
                                    data-assembly-item-id={assemblyItem.id}
                                    onClick={this.props.onClickAddAssemblyItemHandler}
                                >
                                    {buttonText}
                                </button>
                            </li>
                        </ul>
                    </div>
                </li>
            );
        });

        return assemblyItemListJsx;
    }

    _buildAccordionListClassnames() {
        return classnames({
            vlist: true,
            'vlist-short': true,
            'u-isVisuallyHidden': !this.props.isOpen,
        });
    }

    render() {
        return (
            <li key={`assembly-${this.props.assembly.name}`}>
                {this._buildAssemblyGroupHeaderJsx()}
                <ul className={this._buildAccordionListClassnames()}>
                    {this._buildAssemblyItemList()}
                </ul>
            </li>
        );
    }
}

AssemblyItem.propTypes = {
    assembly: PropTypes.object.isRequired,
    assemblyItemsGroupedByAssemblyId: PropTypes.object.isRequired,
    departmentIdMap: PropTypes.object.isRequired,
    isAssemblyItemSubmitSuccess: PropTypes.bool.isRequired,
    isOpen: PropTypes.bool.isRequired,
    isSubmitAssemblySuccess: PropTypes.bool.isRequired,
    isSubmittingAssembly: PropTypes.bool.isRequired,
    itemIdMap: PropTypes.object.isRequired,
    onClickAccordionTriggerHandler: PropTypes.func.isRequired,
    onClickAddAssemblyHandler: PropTypes.func.isRequired,
    onClickAddAssemblyItemHandler: PropTypes.func.isRequired,
    submittedAssemblyItemId: PropTypes.number.isRequired,
};
