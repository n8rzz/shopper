import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';

export function Notice(props) {
    const noticeClassnames = classnames({
        notice: true,
        'u-isVisuallyHidden': props.message === '' || props.isVisible === false,
    });

    return (
        <div className={noticeClassnames}>
            {props.message}
        </div>
    );
}

Notice.propTypes = {
    message: PropTypes.string.isRequired,
    isVisible: PropTypes.bool.isRequired,
};
