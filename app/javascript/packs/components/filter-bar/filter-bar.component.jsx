import React from 'react';
import PropTypes from 'prop-types';
import _noop from 'lodash/noop';
import { FilterBarItem } from './filter-bar-item.component';

export class FilterBar extends React.PureComponent {
    constructor(props) {
        super(props);

        this._onChangeFilterHandler = this._onChangeFilter.bind(this);
        this.state = {
            activeFilter: props.initialSelection,
        };
    }

    componentWillUnmount() {
        this._onChangeFilterHandler = null;
    }

    _buildFilterBarListItemsJsx() {
        return this.props.items.map((filterBarItem, index) => {
            const isActive = this.state.activeFilter === filterBarItem.text;

            return (
                <FilterBarItem
                    key={`filterBar-item-${index}`}
                    isActive={isActive}
                    text={filterBarItem.text}
                    url={filterBarItem.url}
                    onChangeFilterHandler={this._onChangeFilterHandler}
                />
            );
        });
    }

    _onChangeFilter(event) {
        this.setState({ activeFilter: event.target.text }, this.props.onChangeFilterHandler(event));
    }

    render() {
        const filterbarListItemsJsx = this._buildFilterBarListItemsJsx();

        return (
            <ul className={'filterBar'}>
                {filterbarListItemsJsx}
            </ul>
        );
    }
}

FilterBar.propTypes = {
    items: PropTypes.array.isRequired,
    initialSelection: PropTypes.string.isRequired,
    onChangeFilterHandler: PropTypes.func,
};

FilterBar.defaultProps = {
    onChangeFilterHandler: _noop,
};
