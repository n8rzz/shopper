import React from 'react';
import PropTypes from 'prop-types';
import ApiService from '../service/api.service';
import EventService from '../service/event.service';
import { EVENT_NAME } from '../constants/event-names';
import { AssemblyItem } from './assembly-item.component';

export class AssemblyItemContainer extends React.Component {
    constructor(props) {
        super(props);

        this._onClickAccordionTriggerHandler = this._onClickAccordionTrigger.bind(this);
        this._onClickAddAssemblyHandler = this._onClickAddAssembly.bind(this);
        this._onClickAddAssemblyItemHandler = this._onClickAddAssemblyItem.bind(this);
        this._onSubmitAddAssemblySuccessHandler = this._onSubmitAddAssemblySuccess.bind(this);
        this._onSubmitAddAssemblyItemSuccessHandler = this._onSubmitAddAssemblyItemSuccess.bind(this);

        this.state = {
            isOpen: false,
            isSubmittingAssembly: false,
            isSubmitAssemblySuccess: false,
            submittedAssemblyItemId: -1,
            isAssemblyItemSubmitSuccess: false,
        };
    }

    _onClickAccordionTrigger() {
        this.setState((prevState) => ({ isOpen: !prevState.isOpen }));
    }

    _onClickAddAssembly(event) {
        event.preventDefault();
        event.currentTarget.blur();

        // /order_items/create/assembly
        const assemblyId = this.props.assembly.id;
        // FIXME: move these away from data attributes
        const addAssemblyToOrderUrl = '/order_items/create/assembly.json';
        const requestPayload = {
            assembly_id: assemblyId,
        };

        this.setState({ isSubmittingAssembly: true }, this._onSubmitAddAssembly(addAssemblyToOrderUrl, requestPayload));
    }

    _onSubmitAddAssembly(addAssemblyToOrderUrl, requestPayload) {
        ApiService.post(addAssemblyToOrderUrl, requestPayload, this.props.csrf)
            .then((response) => {
                if (response.status >= 300) {
                    console.error(`
                        Received an unexpected status code from ${addAssemblyToOrderUrl}. See response: ${response}
                    `);

                    return;
                }

                const notice = `${this.props.assembly.name} added to order`;

                EventService.emit(EVENT_NAME.NOTICE_SUCCESS, notice);

                this.setState(
                    { isSubmittingAssembly: false, isSubmitAssemblySuccess: true },
                    this._onSubmitAddAssemblySuccessHandler,
                );
            })
            .catch((error) => { throw error; });
    }

    _onSubmitAddAssemblySuccess() {
        setTimeout(() => {
            this.setState({ isSubmitAssemblySuccess: false });
        }, 3000);
    }

    _onClickAddAssemblyItem(event) {
        event.preventDefault();
        event.currentTarget.blur();

        const assemblyId = this.props.assembly.id;
        // FIXME: move these away from data attributes
        const { assemblyItemId, assemblyItemName, departmentId } = event.currentTarget.dataset;
        const assemblyItemUrl = '/order_items/create/item.json';
        const requestPayload = {
            assembly_id: assemblyId,
            department_id: departmentId,
            item_id: assemblyItemId,
        };

        this.setState(
            { submittedAssemblyItemId: parseInt(assemblyItemId, 10) },
            this._onSubmitAddAssemblyItem(assemblyItemName, assemblyItemUrl, requestPayload),
        );
    }

    _onSubmitAddAssemblyItem(assemblyItemName, assemblyItemUrl, requestPayload) {
        ApiService.post(assemblyItemUrl, requestPayload, this.props.csrf)
            .then((response) => {
                if (response.status >= 300) {
                    console.error(`
                        Received an unexpected status code from ${assemblyItemUrl}. See response: ${response}
                    `);

                    return;
                }

                const notice = `${assemblyItemName} added to order`;

                EventService.emit(EVENT_NAME.NOTICE_SUCCESS, notice);

                this.setState({ isAssemblyItemSubmitSuccess: true }, this._onSubmitAddAssemblyItemSuccessHandler);
            })
            .catch((error) => { throw error; });
    }

    _onSubmitAddAssemblyItemSuccess() {
        setTimeout(() => {
            this.setState({
                isAssemblyItemSubmitSuccess: false,
                submittedAssemblyItemId: -1,
            });
        }, 3000);
    }

    render() {
        return (
            <AssemblyItem
                assembly={this.props.assembly}
                assemblyItemsGroupedByAssemblyId={this.props.assemblyItemsGroupedByAssemblyId}
                departmentIdMap={this.props.departmentIdMap}
                itemIdMap={this.props.itemIdMap}
                isSubmittingAssembly={this.state.isSubmittingAssembly}
                isSubmitAssemblySuccess={this.state.isSubmitAssemblySuccess}
                isAssemblyItemSubmitSuccess={this.state.isAssemblyItemSubmitSuccess}
                submittedAssemblyItemId={this.state.submittedAssemblyItemId}
                isOpen={this.state.isOpen}
                onClickAccordionTriggerHandler={this._onClickAccordionTriggerHandler}
                onClickAddAssemblyHandler={this._onClickAddAssemblyHandler}
                onClickAddAssemblyItemHandler={this._onClickAddAssemblyItemHandler}
            />
        );
    }
}

AssemblyItemContainer.propTypes = {
    assembly: PropTypes.object.isRequired,
    assemblyItemsGroupedByAssemblyId: PropTypes.object.isRequired,
    csrf: PropTypes.string.isRequired,
    departmentIdMap: PropTypes.object.isRequired,
    itemIdMap: PropTypes.object.isRequired,
};
