import React from 'react';
import PropTypes from 'prop-types';
import { FilterBar } from '../components/filter-bar/filter-bar.component';
import { ItemList } from './item-list.component';
import { GroupedItemList } from './grouped-item-list.component';
import {
    FILTER_CONCERN,
    FILTER_LABEL,
} from '../constants/filter-concern';

export const FILTER_BAR_ITEMS = [
    {
        text: FILTER_LABEL.ALPHA,
        url: '',
    },
    {
        text: FILTER_LABEL.DEPARTMENT,
        url: '',
    },
    {
        text: FILTER_LABEL.FILTER,
        url: '',
    },
];
export const DEFAULT_DRILL_DOWN_VALUE = '--';

export class ItemListPage extends React.Component {
    constructor(props) {
        super(props);

        this._departmentMap = this._buildDepartmentMap(props);
        this._itemsByFirstLetter = this._buildItemsByFirstLetter(props);
        this._filterableItemList = Object.keys(this._itemsByFirstLetter);
        this._onChangeFilterHandler = this._onChangeFilter.bind(this);
        this._onChangeLetterFilterValueHandler = this._onChangeLetterFilterValue.bind(this);
        this.state = {
            concern: FILTER_CONCERN.ALPHA,
            itemsByFilter: props.items,
        };
    }

    componentWillUnmount() {
        this._onChangeFilterHandler = null;
        this._onChangeLetterFilterValueHandler = null;
    }

    _buildSecondaryFilterOptionListJsx() {
        return (
            <select
                name={'filter-item-by-first-letter'}
                className={'input-select'}
                onChange={this._onChangeLetterFilterValueHandler}
            >
                <option value={DEFAULT_DRILL_DOWN_VALUE}>{DEFAULT_DRILL_DOWN_VALUE}</option>
                {this._filterableItemList.map((filterableLetter, index) => (
                    <option
                        value={filterableLetter}
                        key={`select-${index}`}
                    >
                        {filterableLetter.toUpperCase()}
                    </option>
                ))}
            </select>
        );
    }

    _buildItemListForActiveConcernJsx() {
        switch (this.state.concern) {
            case FILTER_CONCERN.DEPARTMENT:
                return (
                    <GroupedItemList
                        csrf={this.props.csrf}
                        departments={this.props.departments}
                        departmentMap={this._departmentMap}
                        items={this.props.items}
                    />
                );
            case FILTER_CONCERN.FILTER:
                return (
                    <React.Fragment>
                        <div className={'vr_3'}>
                            {this._buildSecondaryFilterOptionListJsx()}
                        </div>

                        <ItemList
                            csrf={this.props.csrf}
                            departmentMap={this._departmentMap}
                            itemList={this.state.itemsByFilter}
                        />
                    </React.Fragment>
                );
            default:
                return (
                    <ItemList
                        csrf={this.props.csrf}
                        departmentMap={this._departmentMap}
                        itemList={this.props.items}
                    />
                );
        }
    }

    // TODO: rename this
    _onChangeLetterFilterValue(event) {
        const nextLetterFilter = event.target.value;
        let itemsByFilter = this._itemsByFirstLetter[nextLetterFilter];

        if (nextLetterFilter === DEFAULT_DRILL_DOWN_VALUE) {
            itemsByFilter = this.props.items;
        }

        this.setState({ itemsByFilter });
    }

    _onChangeFilter(event) {
        event.preventDefault();

        const filterName = event.currentTarget.text.toUpperCase();

        this.setState({ concern: FILTER_CONCERN[filterName] });
    }

    _buildDepartmentMap(props) {
        return props.departments.reduce((sum, department) => {
            sum[department.id] = department;

            return sum;
        }, {});
    }

    _buildItemsByFirstLetter(props) {
        return props.items.reduce((sum, item) => {
            const firstLetter = item.name.substr(0, 1).toLowerCase();

            if (typeof sum[firstLetter] !== 'undefined') {
                sum[firstLetter] = [
                    ...sum[firstLetter],
                    item,
                ];

                return sum;
            }

            sum[firstLetter] = [item];

            return sum;
        }, {});
    }

    render() {
        return (
            <React.Fragment>
                <FilterBar
                    initialSelection={FILTER_LABEL.ALPHA}
                    items={FILTER_BAR_ITEMS}
                    onChangeFilterHandler={this._onChangeFilterHandler}
                />
                {this._buildItemListForActiveConcernJsx()}
            </React.Fragment>
        );
    }
}

ItemListPage.propTypes = {
    csrf: PropTypes.string.isRequired,
    departments: PropTypes.array.isRequired,
    items: PropTypes.array.isRequired,
};
