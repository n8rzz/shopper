import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';

function calculateProgressPercentage(current, total) {
    const progressRatio = (current / total) * 100;

    return `${Math.ceil(progressRatio)}%`;
}

export function Progress(props) {
    const style = {
        width: calculateProgressPercentage(props.currentCount, props.totalCount),
    };
    const progressbarFillClassnames = classnames({
        'progress-bar-fill': true,
        'mix-progress-bar-fill_isComplete': props.currentCount === props.totalCount,
    });

    return (
        <div className={'progress'}>
            <div className={'progress-caption'}>
                {props.currentCount}
            </div>
            <div className={'progress-bar'}>
                <div
                    className={progressbarFillClassnames}
                    style={style}
                >
                    &nbsp;
                </div>
            </div>
            <div className={'progress-caption'}>
                {props.totalCount}
            </div>
        </div>
    );
}

Progress.propTypes = {
    currentCount: PropTypes.number.isRequired,
    totalCount: PropTypes.number.isRequired,
};
