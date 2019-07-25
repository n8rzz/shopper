import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';

function buildClassNames(props) {
    return classnames({
        notice: true,
        'u-isVisuallyHidden': props.message == null || props.isVisible === false,
    });
}

export function Notice(props) {
    return (
        <div className={buildClassNames(props)}>
            {props.message}
        </div>
    );
}

Notice.propTypes = {
    message: PropTypes.string,
    isVisible: PropTypes.bool.isRequired,
};
