<?php 
/**
* 
*/
abstract class TrackStarActiveRecord extends CActiveRecord
{
	protected function beforeValidate()
	{

		if ($this->isNewRecord) {
			$this->create_time = $this->update_time = new CDbExpression('NOW()');
			$this->create_user_id=$this->update_user_id= Yii::app()->user->id;
		}
		else
		{
			$this->update_time = new CDbExpression('NOW()');
			$this->update_user_id=Yii::app()->user->id;
		}

		return parent::beforeValidate();
	}

	protected function afterValidate()
	{

		parent::afterValidate(); 
		//$this->password = $this->encrypt($this->password);
	}

	public function encrypt($value) 
	{ 
		return md5($value); 
	}
}
 ?>