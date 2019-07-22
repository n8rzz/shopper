import React from 'react';
import PropTypes from 'prop-types';

export function FilterBarItem(props) {
    return (
        <li>
            <a
                className="filterBar-link"
                href={props.url}
                onClick={props.onChangeFilterHandler}
            >
                {props.text}
            </a>
        </li>
    );
}

FilterBarItem.propTypes = {
    text: PropTypes.string.isRequired,
    url: PropTypes.string.isRequired,
    onChangeFilterHandler: PropTypes.func,
};
