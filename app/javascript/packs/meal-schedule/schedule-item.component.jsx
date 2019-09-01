import React from 'react';
import PropTypes from 'prop-types';

function onClickRemove(event, props) {
    event.preventDefault();
    props.onClickRemoveHandler(props.mealScheduleId);
}

export function ScheduleItem(props) {
    return (
        <li className={'mealSchedule-bd-itemList-item'}>
            <ul className={'stereo'}>
                <li>
                    {props.scheduleItem.name}
                </li>
                <li>
                    <ul className={'hlist'}>
                        <li className={'u-isVisuallyHidden'}>
                            <button
                                type={'button'}
                                className={'icon-btn'}
                            >
                                <span className={'icon icon-cart-check'} />
                            </button>
                        </li>
                        <li>
                            <button
                                type={'button'}
                                className={'icon-btn js-mealSchedule-remove'}
                                onClick={(event) => onClickRemove(event, props)}
                            >
                                <span className={'icon icon-trashcan'} />
                            </button>
                        </li>
                    </ul>
                </li>
            </ul>
        </li>
    );
}

ScheduleItem.propTypes = {
    // eslint-disable-next-line react/no-unused-prop-types
    mealScheduleId: PropTypes.number.isRequired,
    scheduleItem: PropTypes.object.isRequired,
    // eslint-disable-next-line react/no-unused-prop-types
    onClickRemoveHandler: PropTypes.func.isRequired,
};
