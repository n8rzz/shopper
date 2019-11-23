import React from 'react';
import PropTypes from 'prop-types';
import { StepperContainer } from '../components/stepper/stepper.container';

export function Item(props) {
    const editItemPath = `items/${props.itemId}/edit`;

    return (
        <li className={'js-item'}>
            <div className={'listItem mix-listItem_flex'}>
                <div className={'listItem-content'}>
                    <div className={'listItem-hd'}>
                        <h2 className={'hdg hdg_3'}>
                            <a
                                className={'link'}
                                href={editItemPath}
                            >
                                {props.itemName}
                            </a>
                        </h2>
                    </div>
                    <div className={'listItem-ft'}>
                        { props.departmentName }
                    </div>
                </div>
                <div className={'listItem-action'}>
                    <StepperContainer
                        csrf={props.csrf}
                        departmentId={props.departmentId}
                        itemName={props.itemName}
                        itemId={props.itemId}
                        isSubmitting={props.isSubmitting}
                        isSubmitSuccess={props.isSubmitSuccess}
                        onSubmitHandler={props.onSubmitHandler}
                    />
                </div>
            </div>
        </li>
    );
}

Item.propTypes = {
    csrf: PropTypes.string.isRequired,
    departmentId: PropTypes.number.isRequired,
    departmentName: PropTypes.string.isRequired,
    itemId: PropTypes.number.isRequired,
    itemName: PropTypes.string.isRequired,

    isSubmitting: PropTypes.bool.isRequired,
    isSubmitSuccess: PropTypes.bool.isRequired,
    onSubmitHandler: PropTypes.func.isRequired,
};
