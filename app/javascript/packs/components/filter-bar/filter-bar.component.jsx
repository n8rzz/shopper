import React from 'react';
import PropTypes from 'prop-types';
import { FilterBarItem } from './filter-bar-item.component';

export function FilterBar(props) {
    return (
        <ul className={'filterBar'}>
            {props.items.map((filterBarItem, index) => (
                <FilterBarItem
                    key={`filterBar-item-${index}`}
                    text={filterBarItem.text}
                    url={filterBarItem.url}
                    onChangeFilterHandler={props.onChangeFilterHandler}
                />
            ))}
        </ul>
    );
}

FilterBar.propTypes = {
    items: PropTypes.array.isRequired,
    onChangeFilterHandler: PropTypes.func,
};

FilterBar.defaultProps = {
    onChangeFilterHandler: () => {},
};
