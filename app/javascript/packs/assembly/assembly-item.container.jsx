import React from 'react';
import PropTypes from 'prop-types';
import ApiService from '../service/api.service';
import { AssemblyItem } from './assembly-item.component';

export class AssemblyItemContainer extends React.Component {
    constructor(props) {
        super(props);

        this._onClickAccordionTriggerHandler = this._onClickAccordionTrigger.bind(this);
        this._onClickAddAssemblyHandler = this._onClickAddAssembly.bind(this);
        this._onClickAddAssemblyItemHandler = this._onClickAddAssemblyItem.bind(this);

        this.state = {
            isOpen: false,
        };
    }

    _onClickAccordionTrigger() {
        this.setState((prevState) => ({ isOpen: !prevState.isOpen }));
    }

    _onClickAddAssembly(event) {
        event.preventDefault();

        console.log('+++ _onClickAddAssembly', this.props);

        // /order_items/create/assembly
        const assemblyId = this.props.assembly.id;
        // FIXME: move these away from data attributes
        const addAssemblyToOrderUrl = '/order_items/create/assembly.json';
        const requestPayload = {
            assembly_id: assemblyId,
        };

        ApiService.post(addAssemblyToOrderUrl, requestPayload, this.props.csrf)
            .then((response) => {
                if (response.status >= 300) {
                    console.error(`
                        Received an unexpected status code from ${addAssemblyToOrderUrl}. See response: ${response}
                    `);

                    return;
                }

                console.log('Assembly added successfully.  Need to trigger Notice banner');
                // this._onAddAssemblySuccess(requestPayload, response);
            })
            .catch((error) => { throw error; });
    }

    _onClickAddAssemblyItem(event) {
        event.preventDefault();

        const assemblyId = this.props.assembly.id;
        // FIXME: move these away from data attributes
        const { assemblyItemId, departmentId } = event.currentTarget.dataset;
        const assemblyItemUrl = '/order_items/create/item.json';
        const requestPayload = {
            assembly_id: assemblyId,
            department_id: departmentId,
            item_id: assemblyItemId,
        };

        ApiService.post(assemblyItemUrl, requestPayload, this.props.csrf)
            .then((response) => {
                if (response.status >= 300) {
                    console.error(`
                        Received an unexpected status code from ${assemblyItemUrl}. See response: ${response}
                    `);

                    return;
                }

                console.log('Item added successfully.  Need to trigger Notice banner');
                // this._onAddItemSuccess(requestPayload, response);
            })
            .catch((error) => { throw error; });
    }

    render() {
        return (
            <AssemblyItem
                assembly={this.props.assembly}
                assemblyItemsGroupedByAssemblyId={this.props.assemblyItemsGroupedByAssemblyId}
                departmentIdMap={this.props.departmentIdMap}
                itemIdMap={this.props.itemIdMap}
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
