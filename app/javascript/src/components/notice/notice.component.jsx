import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';

export function Notice(props) {
    const noticeClassnames = classnames({
        notice: true,
        'mix-notice_isAlert': props.isAlert,
        'u-isVisuallyHidden': props.message === '' || !props.isVisible,
    });

    return (
        <div className={noticeClassnames}>
            {props.message}
        </div>
    );
}

Notice.propTypes = {
    message: PropTypes.string.isRequired,
    isAlert: PropTypes.bool.isRequired,
    isVisible: PropTypes.bool.isRequired,
};
