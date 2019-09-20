import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';
import _noop from 'lodash/noop';

export function FilterBarItem(props) {
    const filterBarClassnames = classnames({
        'filterBar-link': true,
        'mix-filterBar-link_isActive': props.isActive,
    });

    return (
        <li>
            <a
                className={filterBarClassnames}
                href={props.url}
                onClick={props.onChangeFilterHandler}
            >
                {props.text}
            </a>
        </li>
    );
}

FilterBarItem.propTypes = {
    isActive: PropTypes.bool.isRequired,
    text: PropTypes.string.isRequired,
    url: PropTypes.string.isRequired,
    onChangeFilterHandler: PropTypes.func,
};

FilterBarItem.defaultProps = {
    onChangeFilterHandler: _noop,
};
