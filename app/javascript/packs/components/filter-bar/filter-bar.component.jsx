import React from 'react';
import PropTypes from 'prop-types';
import {FilterBarItem} from './filter-bar-item.component';

export function FilterBar(props) {
    return (
        <ul className="filterBar">
            {props.items.map((filterBarItem, index) => {
                return (
                    <FilterBarItem
                        key={`filterBar-item-${index}`}
                        text={filterBarItem.text}
                        url={filterBarItem.url}
                    />
                );
            })}
        </ul>
    );
}

FilterBar.propTypes = {
    items: PropTypes.array.isRequired
};
